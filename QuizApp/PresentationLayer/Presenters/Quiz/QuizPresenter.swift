//
//  QuizPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizPresenter: QuizPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    weak var delegate: QuizDelegate?
    
    let quiz: QuizViewModel
    
    init(delegate qd: QuizDelegate, coordinator qc: QuizzesCoordinator, quiz: QuizViewModel) {
        qd.setQuiz(quiz: quiz)
        self.delegate = qd
        self.coordinator = qc
        self.quiz = quiz
    }
    
    func handleFinishedQuiz(correctAnswers: Int, elapsedTime time: CFAbsoluteTime) {
        coordinator?.handleQuizFinished(correctAnswers: correctAnswers, elapsedTime: time, quiz: self.quiz)
    }
    
    func getNoOfQuestions() -> (Int) {
        return quiz.questions.count
    }
}
