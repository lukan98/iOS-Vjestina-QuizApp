//
//  QuizRepositoryProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 28.05.2021..
//

import Foundation

protocol QuizRepositoryProtocol {
    
    func fetchRemoteData(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void)
    func fetchLocalData(filter: FilterSettings) -> [Quiz]

}
