//
//  QuizUseCaseProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 29.05.2021..
//

import Foundation

protocol QuizUseCaseProtocol {
    
    func fetchRemoteQuizzes(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void)
    func fetchLocalQuizzes(filter: FilterSettings) -> [Quiz]
    
}
