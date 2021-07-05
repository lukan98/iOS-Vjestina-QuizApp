//
//  QuizNetworkDataSourceProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

protocol QuizNetworkDataSourceProtocol {
    
    func fetchQuizzesFromNetwork(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void)
    
}
