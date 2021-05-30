//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Luka Namačinski on 28.05.2021..
//

import Foundation

class QuizRepository: QuizRepositoryProtocol {    
    
    private let databaseDataSource: QuizDatabaseDataSourceProtocol
    private let networkDataSource: QuizNetworkDataSourceProtocol
    
    init(databaseDataSource: QuizDatabaseDataSourceProtocol, networkDataSource: QuizNetworkDataSourceProtocol) {
        self.databaseDataSource = databaseDataSource
        self.networkDataSource = networkDataSource
    }
    
    func fetchRemoteData(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void) {
        let quizzes = fetchLocalData(filter: FilterSettings())
        if quizzes.count > 0 {
            print("Found local data")
            completionHandler(.success(QuizCollection(quizzes: quizzes)))
        } else {
            print("Didn't find local data")
            self.networkDataSource.fetchQuizzesFromNetwork(completionHandler: { [weak self]
                (result: Result<QuizCollection, RequestError>) -> Void in
                guard let self = self else { return }
                
                switch result {
                case .success(let fetchedCollection):
                    print(fetchedCollection.quizzes.count)
                    self.databaseDataSource.saveNewQuizzes(fetchedCollection.quizzes)
                    completionHandler(result)
                case .failure:
                    completionHandler(result)
                }
            })
        }
    }
    
    func fetchLocalData(filter: FilterSettings) -> [Quiz] {
        return databaseDataSource.fetchQuizzesfromDatabase(filter: filter)
    }
    
}
