//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizzesPresenter: QuizzesPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    var dataService: NetworkServiceProtocol = NetworkService()
    var delegate: QuizzesDelegate
    
    var quizzes: [Quiz] {
        didSet {
            if quizzes.count > 0 {
                delegate.showQuizzes()
            }
            else {
                delegate.showError()
            }
        }
    }
    var categorisedQuizzes: [QuizCategory : [Quiz]]
    
    init(delegate qd: QuizzesDelegate, coordinator qc: QuizzesCoordinator) {
        self.delegate = qd
        self.coordinator = qc
        self.quizzes = []
        self.categorisedQuizzes = [:]
    }
    
    func fetchQuizzes() {
        DispatchQueue.global().async {
            self.dataService.fetchQuizes(completionHandler: {
                (result: Result<QuizCollection, RequestError>) -> Void in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.delegate.setErrorMessage(message: error.localizedDescription)
                        self.quizzes = []
                    case .success(let fetchedCollection):
                        self.quizzes = fetchedCollection.quizzes
                        self.setFunFact()
                    }
                    self.categorisedQuizzes = Dictionary(grouping: self.quizzes, by: {$0.category})
                    self.delegate.reloadTable()
                }
            })
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
    
    private func calculateFunFactOccurence(funFactWord: String) -> (Int) {
        return quizzes.flatMap({$0.questions}).map({$0.question}).filter({$0.contains(funFactWord)}).count
    }
    
    private func setFunFact() {
        let funFactWord = "NBA"
        let count = calculateFunFactOccurence(funFactWord: funFactWord)
        delegate.setFunFact(funFact: "Did you know there are \(count) questions with the word \(funFactWord) in them?")
    }
    
}
