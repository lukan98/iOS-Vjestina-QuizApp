//
//  LeaderboardPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class LeaderboardPresenter: LeaderboardPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService.shared
    private let leaderboardUseCase: LeaderboardUseCaseProtocol = LeaderboardUseCase()
    weak var delegate: LeaderboardDelegate?
    
    var quiz: Quiz
    
    private var leaderboard: [LeaderboardResult] {
        didSet {
            if leaderboard.count > 0 {
                delegate!.showTable()
            }
            else {
                delegate!.showError()
            }
        }
    }
    
    init(delegate ld: LeaderboardDelegate, coordinator qc: QuizzesCoordinator, quiz q: Quiz) {
        self.delegate = ld
        self.coordinator = qc
        self.leaderboard = []
        self.quiz = q
    }
    
    func fetchLeaderboard() {
        self.leaderboardUseCase.fetchSortedLeaderboard(forQuizID: self.quiz.id, completionHander: { [weak self]
            (result: Result<[LeaderboardResult], RequestError>) -> Void in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.leaderboard = []
                    self.delegate?.setErrorMessage(message: error.localizedDescription)
                case .success(let leaderboard):
                    self.leaderboard = leaderboard
                }
                self.delegate?.reloadTable()
            }
        })
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
