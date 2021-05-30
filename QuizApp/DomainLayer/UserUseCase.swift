//
//  UserUseCase.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

class UserUseCase: UserUseCaseProtocol {
    
    let dataService: NetworkServiceProtocol = NetworkService.shared
    
    func handleLogin(username: String, password: String, completionHandler: @escaping (Result<User, RequestError>) -> Void) {
        self.dataService.login(username: username, password: password, completionHandler: {
            (loginResult: Result<User, RequestError>) -> Void in
            
            switch loginResult {
            case .success(let fetchedUser):
                UserCredentialsService.setUserCredentials(fetchedUser)
                completionHandler(loginResult)
            default:
                completionHandler(loginResult)
            }
        })
    }

    func logout() {
        UserCredentialsService.removeUserCredentials()
    }
    
}
