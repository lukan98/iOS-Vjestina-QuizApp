//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    func login(username: String, password: String,
               completionHandler: @escaping (Result<User, RequestError>) -> Void)
    func fetchQuizes(completionHandler: @escaping (Result<QuizCollection, RequestError>) -> Void)
    func fetchLeaderboard(forQuizID id: Int,
                          completionHander: @escaping (Result<[LeaderboardResult], RequestError>) -> Void)
    func postQuizResult(quizResult: QuizResult,
                        completionHandler: @escaping (Result<EmptyResponse, RequestError>) -> Void)
}
