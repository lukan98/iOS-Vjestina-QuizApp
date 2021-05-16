//
//  LeaderboardResult.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

struct LeaderboardResult: Codable {
    var username: String
    var score: String?
}

struct Leaderboard: Codable {
    var results: [LeaderboardResult]
}

extension LeaderboardResult {
    
    static func leaderboardSorter(resultA: LeaderboardResult, resultB: LeaderboardResult) -> (Bool) {
        // TODO:Feels kinda hacky. Look into streamlining.
        var scoreA, scoreB: Double
        if resultA.score == nil {
            scoreA = 0
        } else {
            scoreA = Double(resultA.score!)!
        }
        if resultB.score == nil {
            scoreB = 0
        } else {
            scoreB = Double(resultB.score!)!
        }
        if scoreA == 0 && scoreB == 0 {
            return resultA.username > resultB.username
        }
        return scoreA > scoreB
    }
    
}
