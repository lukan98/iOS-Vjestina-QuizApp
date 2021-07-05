//
//  QuizUseCase.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

class QuizUseCase: QuizUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol
    private let dataService: NetworkServiceProtocol = NetworkService.shared
    
    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }
    
    func fetchRemoteQuizzes(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void) {
        quizRepository.fetchRemoteData(completionHandler: completionHandler)
    }
    
    func fetchLocalQuizzes(filter: String) -> [Quiz] {
        return quizRepository.fetchLocalData(filter: FilterSettings(searchText: filter))
    }
    
    func fetchLocalQuizzes() -> [Quiz] {
        return quizRepository.fetchLocalData(filter: FilterSettings())
    }
    
    func postQuizResult(result: QuizResult, completionHandler: @escaping (Result<EmptyResponse, RequestError>) -> Void) {
        self.dataService.postQuizResult(quizResult: result, completionHandler: completionHandler)
    }
    
}
