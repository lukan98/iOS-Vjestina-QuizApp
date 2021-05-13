//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol NetworkServiceProtocol {
    func login(email: String, password: String) -> LoginStatus
    func fetchQuizes() -> [Quiz]
    func getNoOfQuizCategories() -> (Int)
    func getRandomFunFactWord() -> (String)
    func getLeaderboard(forQuizID id: Int) -> [LeaderboardResult]
}
