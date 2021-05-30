//
//  UserCredentialsServiceProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 24.05.2021..
//

import Foundation

protocol UserCredentialsServiceProtocol {
    static func setUserCredentials(_ user: User)
    static func removeUserCredentials()
    static func getCurrentUserID() -> Int
}
