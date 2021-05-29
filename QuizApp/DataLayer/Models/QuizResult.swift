//
//  QuizResult.swift
//  QuizApp
//
//  Created by Luka Namačinski on 13.05.2021..
//

import Foundation

struct QuizResult: Codable {
    let quizID: Int
    let userID: Int
    let time: Double
    let noOfCorrect: Int
    
    enum CodingKeys: String, CodingKey {
        case quizID = "quiz_id"
        case userID = "user_id"
        case time
        case noOfCorrect = "no_of_correct"
    }
}
