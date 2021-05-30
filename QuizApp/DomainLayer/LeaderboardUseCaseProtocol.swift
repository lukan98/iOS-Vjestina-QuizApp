//
//  LeaderboardUseCaseProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

protocol LeaderboardUseCaseProtocol {
    
    func fetchSortedLeaderboard(forQuizID id: Int,
                                completionHander: @escaping (Result<[LeaderboardResult], RequestError>) -> Void)
    
}
