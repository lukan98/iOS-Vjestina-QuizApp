//
//  QuizPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizPresenter: QuizPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService.shared
    weak var delegate: QuizDelegate?
    
    let quiz: QuizViewModel
    
    init(delegate qd: QuizDelegate, coordinator qc: QuizzesCoordinator, quiz: QuizViewModel) {
        self.delegate = qd
        self.coordinator = qc
        self.quiz = quiz
        self.delegate!.setQuiz(quiz: quiz)
    }
    
    func handleFinishedQuiz(correctAnswers: Int, elapsedTime time: CFAbsoluteTime) {
        coordinator?.handleQuizFinished(correctAnswers: correctAnswers, elapsedTime: time, quiz: self.quiz)
    }
    
    func getNoOfQuestions() -> (Int) {
        return quiz.questions.count
    }
}
