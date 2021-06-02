//
//  LoginDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import Foundation

protocol LoginDelegate: AnyObject { 
    func handleSignInError(errorMessage error: String)
    func handleSignInSuccess(completionHandler: @escaping (Bool) -> Void)
}
