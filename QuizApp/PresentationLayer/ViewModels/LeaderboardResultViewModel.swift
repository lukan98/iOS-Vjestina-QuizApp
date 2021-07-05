//
//  LeaderboardResultViewModel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation

struct LeaderboardResultViewModel {
    
    let username: String
    let score: Double
    
    init(_ leaderboardResult: LeaderboardResult) {
        self.username = leaderboardResult.username
        guard let scoreString = leaderboardResult.score else {
            self.score = 0
            return
        }
        self.score = Double(scoreString) ?? 0
    }
    
}
