//
//  LeaderboardPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol LeaderboardPresenterProtocol: Presenter {
    func fetchAndSortLeaderboard()
    func getLeaderboardSize() -> (Int)
    func getUsernameFor(index at: Int) -> (String)
    func getScoreFor(index at: Int) -> (Double)
}
