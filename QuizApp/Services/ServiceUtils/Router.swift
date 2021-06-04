//
//  Router.swift
//  QuizApp
//
//  Created by Luka Namačinski on 13.05.2021..
//

import Foundation

enum Router {
    case login(username: String, password: String)
    case getQuizzes
    case postQuizResult(result: QuizResult)
    case getLeaderboard(id: Int)

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
        case .getQuizzes:
            return "/api/quizzes"
        case .postQuizResult:
            return "/api/result"
        case .getLeaderboard:
            return "/api/score"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .login(let username, let password):
            return [URLQueryItem(name: "username", value: username),
                    URLQueryItem(name: "password", value: password)]
        case .getLeaderboard(let quizID):
            return [URLQueryItem(name: "quiz_id", value: String(quizID))]
        default:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .login, .postQuizResult:
            return "POST"
        case .getQuizzes, .getLeaderboard:
            return "GET"
        }
    }
    
    var body: Data? {
        switch self {
        case .postQuizResult(let quizResult):
            let data = try! JSONEncoder().encode(quizResult)
            return data
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postQuizResult, .getLeaderboard:
            return [User.tokenKey : UserDefaults.standard.string(forKey: User.tokenKey)!,
                    "Content-Type" : "application/json"]
        default:
            return nil
        }
    }
}
