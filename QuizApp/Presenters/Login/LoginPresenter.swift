//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    weak var coordinator: LoginCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService()
    var delegate: LoginDelegate
    
    init(delegate ld: LoginDelegate, coordinator lc: LoginCoordinator) {
        self.delegate = ld
        self.coordinator = lc
    }
    
    func handleLogin(username: String, password: String) {
        DispatchQueue.global().async {
            self.dataService.login(username: username, password: password, completionHandler: {
                (loginResult: Result<User, RequestError>) -> Void in
                switch loginResult {
                case .failure(let requestError):
                    DispatchQueue.main.async {
                        //TODO: Fix error messages (but the error is always nil)
                        self.delegate.handleSignInError(errorMessage: requestError.localizedDescription)
                    }
                case .success(let fetchedUser):
                    UserDefaults.standard.set(fetchedUser.user_id, forKey: User.userIDKey)
                    UserDefaults.standard.set(fetchedUser.token, forKey: User.tokenKey)
                    DispatchQueue.main.async {
                        self.coordinator?.handleLogin()
                    }
                }
            })
        }
    }
}
