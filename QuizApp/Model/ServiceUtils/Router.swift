//
//  Router.swift
//  QuizApp
//
//  Created by Luka Namačinski on 13.05.2021..
//

import Foundation

enum Router {
    case login(username: String, password: String)

    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        default:
            return "iosquiz.herokuapp.com"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/session"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .login(let username, let password):
            return [URLQueryItem(name: "username", value: username),
                    URLQueryItem(name: "password", value: password)]
        }
    }
    
    var method: String {
        switch self {
        case .login:
            return "POST"
        }
    }
}
