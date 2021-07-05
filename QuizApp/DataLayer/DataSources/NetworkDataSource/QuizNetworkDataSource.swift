//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by Luka Namačinski on 28.05.2021..
//

import Foundation

struct QuizNetworkDataSource: QuizNetworkDataSourceProtocol {
    
    private let dataService: NetworkServiceProtocol = NetworkService.shared
    
    func fetchQuizzesFromNetwork(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void) {
        dataService.fetchQuizes(completionHandler: completionHandler)
    }

}
