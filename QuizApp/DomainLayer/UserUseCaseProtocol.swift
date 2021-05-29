//
//  UserUseCaseProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

protocol UserUseCaseProtocol {
    
    func handleLogin(username: String, password: String, completionHandler: @escaping (Result<User, RequestError>) -> Void)
    func logout()
    
}
