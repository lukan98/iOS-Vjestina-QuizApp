//
//  LoginPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    weak var coordinator: LoginCoordinator?
    let dataService: DataServiceProtocol = DataService()
    var delegate: LoginDelegate
    
    init(delegate ld: LoginDelegate, coordinator lc: LoginCoordinator) {
        self.delegate = ld
        self.coordinator = lc
    }
    
    func handleLogin(email: String, password: String) {
        let result: LoginStatus = dataService.login(email: email, password: password)
        switch result {
        case LoginStatus.success:
            coordinator?.handleLogin()
        case LoginStatus.error:
            delegate.handleSignInError()
        }
    }
}
