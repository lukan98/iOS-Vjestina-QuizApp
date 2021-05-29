//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Luka Namačinski on 28.05.2021..
//

import Foundation

class QuizRepository: QuizRepositoryProtocol {    
    
    private let coreDataSource: QuizDatabaseDataSourceProtocol
    private let networkDataSource: QuizNetworkDataSourceProtocol
    
    init(coreDataSource: QuizDatabaseDataSourceProtocol, networkDataSource: QuizNetworkDataSourceProtocol) {
        self.coreDataSource = coreDataSource
        self.networkDataSource = networkDataSource
    }
    
    func fetchRemoteData(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void) {
        networkDataSource.fetchQuizzesFromNetwork(completionHandler: completionHandler)
    }
    
    func fetchLocalData(search: String?) -> [Quiz] {
        return []
    }
    
}
