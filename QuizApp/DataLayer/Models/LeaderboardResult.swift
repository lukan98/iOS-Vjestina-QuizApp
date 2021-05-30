//
//  LeaderboardResult.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

struct LeaderboardResult: Codable, Comparable {
    var username: String
    var score: String?
    
    static func < (lhs: LeaderboardResult, rhs: LeaderboardResult) -> Bool {
        let leftScore = Double(lhs.score ?? "0") ?? 0
        let rightScore = Double(rhs.score ?? "0") ?? 0
        guard leftScore != rightScore else {
            return lhs.username > rhs.username
        }
        return leftScore > rightScore
    }
}
