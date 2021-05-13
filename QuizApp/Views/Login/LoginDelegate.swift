//
//  LoginDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

protocol LoginDelegate: AnyObject {
    var presenter: LoginPresenterProtocol! { get set }
    
    func handleSignInError(errorMessage error: String)
}
