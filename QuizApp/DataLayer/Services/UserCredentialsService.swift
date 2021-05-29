//
//  UserCredentialsService.swift
//  QuizApp
//
//  Created by Luka Namačinski on 24.05.2021..
//

import Foundation

class UserCredentialsService: UserCredentialsServiceProtocol {
    static func setUserCredentials(_ user: User) {
        UserDefaults.standard.set(user.user_id, forKey: User.userIDKey)
        UserDefaults.standard.set(user.token, forKey: User.tokenKey)
    }
    
    static func removeUserCredentials() {
        UserDefaults.standard.removeObject(forKey: User.tokenKey)
        UserDefaults.standard.removeObject(forKey: User.userIDKey)
    }
}
