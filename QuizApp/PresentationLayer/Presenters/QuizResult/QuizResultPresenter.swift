//
//  QuizResultPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizResultPresenter: QuizResultPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService.shared
    weak var delegate: QuizResultDelegate?
    
    let quiz: QuizViewModel
    let correctAnswers: Int
    let elapsedTime: CFAbsoluteTime
    
    init(delegate qrd: QuizResultDelegate, coordinator qc: QuizzesCoordinator,
         quiz qvm: QuizViewModel, correctAnswers: Int, elapsedTime time: CFAbsoluteTime) {
        qrd.setResultLabel(correctAnswers: correctAnswers, totalQuestions: qvm.questions.count)
        self.delegate = qrd
        self.coordinator = qc
        self.quiz = qvm
        self.correctAnswers = correctAnswers
        self.elapsedTime = time
        
        postQuizResult(quizResult: QuizResult(quizID: self.quiz.id,
                                              userID: UserDefaults.standard.integer(forKey: User.userIDKey),
                                              time: self.elapsedTime,
                                              noOfCorrect: self.correctAnswers))
    }
    
    private func postQuizResult(quizResult: QuizResult) {
        self.dataService.postQuizResult(quizResult: quizResult, completionHandler: {
            (result: Result<EmptyResponse, RequestError>) -> Void in
            switch result {
            case .failure(let error):
                print(error.errorDescription!)
            case .success:
                print("Data posted successfully!")
            }
        })
    }
    
    func handleGoToLeaderboard() {
//        coordinator?.handleGoToLeaderboard(quiz: self.quiz)
    }
    
    func handleReviewFinished() {
        coordinator?.handleReviewFinished()
    }
}
