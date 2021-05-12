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
        if Bool.random() {
            self.quizzes = dataService.fetchQuizes()
            setFunFact()
        }
        else {
            self.quizzes = []
        }
        self.categorisedQuizzes = Dictionary(grouping: quizzes, by: {$0.category})
        delegate.reloadTable()
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
    
    private func getFunFactWord() -> (String) {
        return dataService.getRandomFunFactWord()
    }
    
    private func setFunFact() {
        let funFactWord = getFunFactWord()
        let count = calculateFunFactOccurence(funFactWord: funFactWord)
        delegate.setFunFact(funFact: "Did you know there are \(count) quizzes with the word \(funFactWord) in them?")
    }
    
}
