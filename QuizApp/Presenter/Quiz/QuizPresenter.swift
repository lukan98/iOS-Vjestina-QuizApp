//
//  QuizPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizPresenter: QuizPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: DataServiceProtocol = DataService()
    var delegate: QuizDelegate
    
    let quiz: Quiz
    
    init(delegate qd: QuizDelegate, coordinator qc: QuizzesCoordinator, quiz: Quiz) {
        self.delegate = qd
        self.coordinator = qc
        self.quiz = quiz
        self.delegate.setQuiz(quiz: quiz)
    }
    
    func handleFinishedQuiz(correctAnswers: Int) {
        coordinator?.handleQuizFinished(correctAnswers: correctAnswers, quiz: self.quiz)
    }
    
    func getNoOfQuestions() -> (Int) {
        return quiz.questions.count
    }
}
