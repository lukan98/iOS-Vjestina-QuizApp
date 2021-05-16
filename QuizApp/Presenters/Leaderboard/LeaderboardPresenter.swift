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
        DispatchQueue.global().async {
            self.dataService.fetchLeaderboard(forQuizID: self.quiz.id, completionHander: {
                (result: Result<[LeaderboardResult], RequestError>) -> Void in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.leaderboard = []
                        self.delegate.setErrorMessage(message: error.localizedDescription)
                    case .success(let value):
                        self.leaderboard = value
                        // TODO:Feels kinda hacky look into improvements
                        self.leaderboard.sort(by: {
                            entryA, entryB in
                            var scoreA, scoreB: Double
                            if entryA.score == nil {
                                scoreA = 0
                            } else {
                                scoreA = Double(entryA.score!)!
                            }
                            if entryB.score == nil {
                                scoreB = 0
                            } else {
                                scoreB = Double(entryB.score!)!
                            }
                            if scoreA == 0 && scoreB == 0 {
                                return entryA.username > entryB.username
                            }
                            return scoreA > scoreB
                        })
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
