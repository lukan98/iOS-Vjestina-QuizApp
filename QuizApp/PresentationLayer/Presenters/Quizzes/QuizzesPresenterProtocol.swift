//
//  QuizzesPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizzesPresenterProtocol: Presenter {
    
    func fetchQuizzes()
    func getQuizzesByCategory() -> [QuizCategory : [Quiz]]
    func getNoOfQuizCategories() -> Int
    func getQuizCountForCategory(categoryIndex: Int) -> Int
    func getQuizCategoryForSection(section: Int) -> QuizCategory
    func getQuiz(at indexPath: IndexPath) -> Quiz
    func handleQuizSelection(at indexPath: IndexPath)
    
}
