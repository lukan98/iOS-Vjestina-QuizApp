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
