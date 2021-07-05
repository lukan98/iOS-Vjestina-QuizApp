//
//  SearchPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

protocol SearchPresenterProtocol: Presenter {
    
    func fetchQuizzes(filter: String)
    func getNoOfQuizCategories() -> Int
    func getQuizCountForCategory(categoryIndex: Int) -> Int
    func getQuizCategoryForSection(section: Int) -> String
    func getQuiz(at indexPath: IndexPath) -> QuizViewModel?
    func handleQuizSelection(at indexPath: IndexPath)
    
}
