//
//  LeaderboardPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class LeaderboardPresenter: LeaderboardPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService()
    var delegate: LeaderboardDelegate
    
    var quiz: Quiz
    
    private var leaderboard: [LeaderboardResult] {
        didSet {
            if leaderboard.count > 0 {
                delegate.showTable()
            }
            else {
                delegate.showError()
            }
        }
    }
    
    init(delegate ld: LeaderboardDelegate, coordinator qc: QuizzesCoordinator, quiz q: Quiz) {
        self.delegate = ld
        self.coordinator = qc
        self.leaderboard = []
        self.quiz = q
    }
    
    func fetchAndSortLeaderboard() {
//        if Bool.random() {
//            leaderboard = dataService.getLeaderboard(forQuizID: quiz.id)
//            leaderboard.sort(by: {Int($0.score!)! > Int($1.score!)!})
//        }
//        else {
//            leaderboard = []
//        }
        DispatchQueue.global().async {
            self.dataService.fetchLeaderboard(forQuizID: self.quiz.id, completionHander: {
                (result: Result<[LeaderboardResult], RequestError>) -> Void in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let value):
                        self.leaderboard = value
                        self.leaderboard.sort(by: {Double($0.score!)! > Double($1.score!)!})
                    }
                    self.delegate.reloadTable()
                }
            })
        }
    }
    
    func getLeaderboardSize() -> (Int) {
        return leaderboard.count
    }
    
    func getUsernameFor(index at: Int) -> (String) {
        return leaderboard[at].username
    }
    
    func getScoreFor(index at: Int) -> (Double) {
        guard let scoreString = leaderboard[at].score, let scoreString = Double(scoreString) else {
            return 0
        }
        return scoreString
    }
}
