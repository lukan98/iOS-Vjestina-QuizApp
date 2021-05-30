//
//  QuestionViewModel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

struct QuestionViewModel {
    
    let id: Int
    let question: String
    let answers: [String]
    let correctAnswer: Int
    
    init(_ question: Question) {
        self.id = question.id
        self.question = question.question
        self.answers = question.answers
        self.correctAnswer = question.correctAnswer
    }
    
}
