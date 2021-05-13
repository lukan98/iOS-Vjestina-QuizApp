//
//  LoginPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

protocol LoginPresenterProtocol: Presenter {
    var coordinator: LoginCoordinator? { get set }
    var dataService: NetworkServiceProtocol { get }
    var delegate: LoginDelegate { get }
    
    func handleLogin(email: String, password: String)
}
