//
//  QuizDatabaseDataSourceProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

protocol QuizDatabaseDataSourceProtocol {
    
    func fetchQuizzesfromDatabase(filter: FilterSettings) -> [Quiz]
    func saveNewQuizzes(_ quizzes: [Quiz])
    func deleteQuiz(withId id: Int)
    
}
