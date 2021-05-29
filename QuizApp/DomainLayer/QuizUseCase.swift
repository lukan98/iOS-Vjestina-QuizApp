//
//  QuizUseCase.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

class QuizUseCase: QuizUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol
    
    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }
    
    func fetchQuizzes(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void) {
        quizRepository.fetchRemoteData(completionHandler: completionHandler)
    }
    
    func getQuizzes(search: String?) -> [Quiz] {
        quizRepository.fetchLocalData(search: search)
    }
}
