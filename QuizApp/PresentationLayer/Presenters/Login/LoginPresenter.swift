//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    weak var coordinator: LoginCoordinator?
    private let userUseCase: UserUseCaseProtocol = UserUseCase()
    weak var delegate: LoginDelegate?
    
    init(delegate ld: LoginDelegate, coordinator lc: LoginCoordinator) {
        self.delegate = ld
        self.coordinator = lc
    }
    
    func handleLogin(username: String, password: String) {
        self.userUseCase.handleLogin(username: username, password: password, completionHandler: { [weak self]
            (loginResult: Result<User, RequestError>) -> Void in
            guard let self = self else { return }
            
            switch loginResult {
            case .failure(let requestError):
                DispatchQueue.main.async {
                    switch requestError {
                    case .networkError:
                        self.delegate?.handleSignInError(errorMessage: requestError.localizedDescription)
                    default:
                        self.delegate?.handleSignInError(errorMessage: "Username or password incorrect!")
                    }
                }
            case .success:
                DispatchQueue.main.async {
                        self.coordinator?.handleLogin()
                }
            }
        })
    }
    
}
