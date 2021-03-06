//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizzesPresenter: QuizzesPresenterProtocol {
    
    weak var coordinator: QuizzesCoordinator?
    private var quizUseCase: QuizUseCaseProtocol!
    weak var delegate: QuizzesDelegate?
    
    private var quizzes: [QuizViewModel] {
        didSet {
            if quizzes.count > 0 {
                delegate!.showQuizzes()
            }
            else {
                delegate!.showError()
            }
        }
    }
    private var sectionCategories: [String]
    
    init(delegate: QuizzesDelegate, coordinator: QuizzesCoordinator, quizUseCase: QuizUseCaseProtocol) {
        self.delegate = delegate
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
        self.quizzes = []
        self.sectionCategories = []
    }
    
    func fetchQuizzes(filter: String?) {
        DispatchQueue.global().async {
            self.quizUseCase.fetchRemoteQuizzes(completionHandler: { [weak self]
                (result: Result<QuizCollection, RequestError>) -> Void in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.delegate!.setErrorMessage(message: error.localizedDescription)
                        self.quizzes = []
                    case .success:
                        self.setFetchedQuizzes()
                    }
                    self.sectionCategories = Set(self.quizzes.map({$0.category})).sorted()
                    self.delegate!.reloadTable()
                }
            })
        }
    }
    
    private func setFetchedQuizzes() {
        let fetchedQuizzes = self.quizUseCase.fetchLocalQuizzes()
        self.quizzes = fetchedQuizzes.map({QuizViewModel($0)})
        self.setFunFact()
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
    
    private func calculateFunFactOccurence(funFactWord: String) -> (Int) {
        return quizzes.flatMap({$0.questions}).map({$0.question}).filter({$0.contains(funFactWord)}).count
    }
    
    private func setFunFact() {
        let funFactWord = "NBA"
        let count = calculateFunFactOccurence(funFactWord: funFactWord)
        delegate!.setFunFact(funFact: "Did you know there are \(count) questions with the word \(funFactWord) in them?")
    }
    
}
