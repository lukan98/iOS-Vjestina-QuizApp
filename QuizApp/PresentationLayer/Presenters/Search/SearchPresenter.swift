//
//  SearchPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

class SearchPresenter: QuizzesPresenterProtocol {

    weak var coordinator: QuizzesCoordinator?
    private var quizUseCase: QuizUseCaseProtocol!
    weak var delegate: SearchDelegate?
    
    var quizzes: [QuizViewModel]
    var sectionCategories: [String]
    
    init(delegate: SearchDelegate, coordinator: QuizzesCoordinator, quizUseCase: QuizUseCaseProtocol) {
        self.delegate = delegate
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
        self.quizzes = []
        self.sectionCategories = []
    }
    
    func fetchQuizzes(filter: String?) {
        guard let filter = filter else { return }
        DispatchQueue.global().async {
            self.quizzes = self.quizUseCase.fetchLocalQuizzes(filter: filter).map({QuizViewModel($0)})
            self.sectionCategories = Set(self.quizzes.map({$0.category})).sorted()
            DispatchQueue.main.async {
                self.delegate?.reloadTable()
            }
        }
    }
    
    func getNoOfQuizCategories() -> Int {
        return sectionCategories.count
    }
    
    func getQuizCountForCategory(categoryIndex: Int) -> Int {
        return self.quizzes.filter({$0.category == self.sectionCategories[categoryIndex]}).count
    }
    
    func getQuizCategoryForSection(section: Int) -> String {
        guard let section = sectionCategories.at(section) else { return "" }
        return section
    }
    
    func getQuiz(at indexPath: IndexPath) -> QuizViewModel? {
        return self.quizzes.filter({$0.category == sectionCategories[indexPath.section]}).at(indexPath.row)
    }
    
    func handleQuizSelection(at indexPath: IndexPath) {
        guard let selectedQuiz = getQuiz(at: indexPath) else { return }
        coordinator?.handleQuizSelection(quiz: selectedQuiz)
    }
    
}
