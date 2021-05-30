//
//  LeaderboardUseCase.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

class LeaderboardUseCase: LeaderboardUseCaseProtocol {
    
    let dataService = NetworkService.shared
    
    func fetchSortedLeaderboard(forQuizID id: Int,completionHander: @escaping (Result<[LeaderboardResult], RequestError>) -> Void) {
        DispatchQueue.global().async {
            self.dataService.fetchLeaderboard(forQuizID: id, completionHander: {
                (result: Result<[LeaderboardResult], RequestError>) -> Void in
                switch result {
                case .success(let results):
                    let sortedLeaderboard = results.sorted()
                    completionHander(.success(sortedLeaderboard))
                default:
                    completionHander(result)
                }
            })
        }
    }
    
}
