//
//  QuizResultViewModel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

struct QuizResultViewModel {
    let quizID: Int
    let userID: Int
    let time: Double
    let noOfCorrect: Int
    
    init(_ result: QuizResult) {
        self.quizID = result.quizID
        self.userID = result.userID
        self.time = result.time
        self.noOfCorrect = result.noOfCorrect
    }
    
    init(_ quizID: Int, _ userID: Int, _ time: Double, _ noOfCorrect: Int) {
        self.quizID = quizID
        self.userID = userID
        self.time = time
        self.noOfCorrect = noOfCorrect
    }
}
