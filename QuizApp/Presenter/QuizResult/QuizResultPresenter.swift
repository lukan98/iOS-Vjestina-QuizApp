//
//  QuizResultPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizResultPresenter: QuizResultPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService()
    var delegate: QuizResultDelegate
    
    let quiz: Quiz
    let correctAnswers: Int
    let elapsedTime: CFAbsoluteTime
    
    init(delegate qrd: QuizResultDelegate, coordinator qc: QuizzesCoordinator,
         quiz q: Quiz, correctAnswers: Int, elapsedTime time: CFAbsoluteTime) {
        self.delegate = qrd
        self.coordinator = qc
        self.quiz = q
        self.correctAnswers = correctAnswers
        self.elapsedTime = time
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
