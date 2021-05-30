//
//  SearchPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {

    weak var coordinator: QuizzesCoordinator?
    private var quizUseCase: QuizUseCaseProtocol!
    weak var delegate: SearchDelegate?
    
    var quizzes: [Quiz]
    var categorisedQuizzes: [QuizCategory : [Quiz]]
    
    init(delegate: SearchDelegate, coordinator: QuizzesCoordinator, quizUseCase: QuizUseCaseProtocol) {
        self.delegate = delegate
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
        self.quizzes = []
        self.categorisedQuizzes = [:]
    }
    
    func fetchQuizzes(filter: String) {
        DispatchQueue.global().async {
            self.quizzes = self.quizUseCase.fetchLocalQuizzes(filter: filter)
            print(self.quizzes)
            self.categorisedQuizzes = Dictionary(grouping: self.quizzes, by: {$0.category})
            DispatchQueue.main.async {
                self.delegate?.reloadTable()
            }
        }
    }
    
    func getQuizzesByCategory() -> [QuizCategory : [Quiz]] {
        return categorisedQuizzes
    }
    
    func getNoOfQuizCategories() -> Int {
        return categorisedQuizzes.keys.count
    }
    
    func getQuizCountForCategory(categoryIndex: Int) -> Int {
        let quizCategory = getQuizCategoryForSection(section: categoryIndex)
        guard let quizzes = categorisedQuizzes[quizCategory] else { return 0 }
        return quizzes.count
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
