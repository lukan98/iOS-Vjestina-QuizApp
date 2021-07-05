//
//  LoginPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

protocol LoginPresenterProtocol: Presenter {
    func handleLogin(username: String, password: String)
}
