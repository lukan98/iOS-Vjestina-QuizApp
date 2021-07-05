//
//  User.swift
//  QuizApp
//
//  Created by Luka Namačinski on 13.05.2021..
//

struct User: Codable {
    static let tokenKey = "Authorization"
    static let userIDKey = "user_id"
    
    let token: String
    let user_id: Int
}
