//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation
import UIKit

struct QuizViewModel {
    
    let id: Int
    let title: String
    let description: String
    let category: String
    let level: Int
    let questions: [QuestionViewModel]
    
    init(_ quiz: Quiz) {
        self.id = quiz.id
        self.title = quiz.title
        self.description = quiz.description
        self.category = quiz.category.rawValue
        self.level = quiz.level
        self.questions = quiz.questions.map({QuestionViewModel($0)})
    }
    
}
