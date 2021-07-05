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
    
    init(_ quizID: Int, _ userId: Int, _ time: Double, _ noOfCorrect: Int) {
        self.quizID = quizID
        self.userID = userId
        self.time = time
        self.noOfCorrect = noOfCorrect
    }
    
    enum CodingKeys: String, CodingKey {
        case quizID = "quiz_id"
        case userID = "user_id"
        case time
        case noOfCorrect = "no_of_correct"
    }
}
