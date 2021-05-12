//
//  QuizResultPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizResultPresenter: QuizResultPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: DataServiceProtocol = DataService()
    var delegate: QuizResultDelegate
    
    let quiz: Quiz
    let correctAnswers: Int
    
    init(delegate qrd: QuizResultDelegate, coordinator qc: QuizzesCoordinator, quiz q: Quiz, correctAnswers: Int) {
        self.delegate = qrd
        self.coordinator = qc
        self.quiz = q
        self.correctAnswers = correctAnswers
    }
    
    func getResult() -> (correct: Int, total: Int) {
        return (correct: self.correctAnswers,
                total: self.quiz.questions.count)
    }
    
    func handleGoToLeaderboard() {
        coordinator?.handleGoToLeaderboard(quiz: self.quiz)
    }
    
    func handleReviewFinished() {
        coordinator?.handleReviewFinished()
    }
}
