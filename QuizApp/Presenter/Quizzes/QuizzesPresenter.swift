//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizzesPresenter: QuizzesPresenterProtocol {    
    weak var coordinator: QuizzesCoordinator?
    var dataService: DataServiceProtocol = DataService()
    var delegate: QuizzesDelegate
    
    var quizzes: [Quiz]
    var categorisedQuizzes: [QuizCategory : [Quiz]]
    
    init(delegate qd: QuizzesDelegate, coordinator qc: QuizzesCoordinator) {
        self.delegate = qd
        self.coordinator = qc
        self.quizzes = []
        self.categorisedQuizzes = [:]
    }
    
    func fetchQuizzes() {
        self.quizzes = dataService.fetchQuizes()
        self.categorisedQuizzes = Dictionary(grouping: quizzes, by: {$0.category})
    }
    
    func getQuizzesByCategory() -> [QuizCategory : [Quiz]] {
        return categorisedQuizzes
    }
    
    func getNoOfQuizCategories() -> Int {
        return categorisedQuizzes.keys.count
    }
    
    func getQuizCountForCategory(categoryIndex: Int) -> Int {
        let quizCategory = getQuizCategoryForSection(section: categoryIndex)
        return categorisedQuizzes[quizCategory]!.count
    }
    
    func getQuizCategoryForSection(section: Int) -> QuizCategory {
        return QuizCategory.allCases[section]
    }
    
    func getQuiz(at indexPath: IndexPath) -> Quiz {
        let quizCategory = QuizCategory.allCases[indexPath.section]
        return categorisedQuizzes[quizCategory]![indexPath.row]
    }
    
    func handleQuizSelection(at indexPath: IndexPath) {
        coordinator?.handleQuizSelection(quiz: getQuiz(at: indexPath))
    }
    
}
