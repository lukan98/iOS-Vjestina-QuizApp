//
//  QuizResultPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class QuizResultPresenter: QuizResultPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
//    let dataService: NetworkServiceProtocol = NetworkService.shared
    private let quizUseCase: QuizUseCaseProtocol
    private let userUseCase: UserUseCaseProtocol = UserUseCase()
    weak var delegate: QuizResultDelegate?
    
    let quiz: QuizViewModel
    let result: QuizResultViewModel
    
    init(delegate qrd: QuizResultDelegate, coordinator qc: QuizzesCoordinator,
         quiz qvm: QuizViewModel, correctAnswers: Int, elapsedTime time: CFAbsoluteTime,
         quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
        qrd.setResultLabel(correctAnswers: correctAnswers, totalQuestions: qvm.questions.count)
        self.delegate = qrd
        self.coordinator = qc
        self.quiz = qvm
        self.result = QuizResultViewModel(qvm.id, userUseCase.getCurrentUserID(), time, correctAnswers)
        
        postQuizResult(quizResult: self.result)
    }
    
    private func postQuizResult(quizResult: QuizResultViewModel) {
        let result = QuizResult(quizResult.quizID, quizResult.userID, quizResult.time, quizResult.noOfCorrect)
        self.quizUseCase.postQuizResult(result: result, completionHandler: {
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
        coordinator?.handleGoToLeaderboard(quiz: self.quiz)
    }
    
    func handleReviewFinished() {
        coordinator?.handleReviewFinished()
    }
}
