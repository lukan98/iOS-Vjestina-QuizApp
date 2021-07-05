//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.05.2021..
//

import UIKit

class LeaderboardViewController: UIViewController, LeaderboardDelegate {
    var presenter: LeaderboardPresenterProtocol!
    
    var titleLabel: Label!
    var exitButton: UIImageView!
    
    var errorMessage: Label!
    
    var leaderboardView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leaderboard"
        buildViews()
        presenter.fetchLeaderboard()
    }
    
    func showError() {
        leaderboardView.isHidden = true
        errorMessage.isHidden = false
    }
    
    func setErrorMessage(message: String) {
        errorMessage.text = message
    }
    
    func showTable() {
        leaderboardView.isHidden = false
        errorMessage.isHidden = true
    }
    
    func reloadTable() {
        leaderboardView.reloadData()
    }
    
    @objc
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
}

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getLeaderboardSize()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderboardView.dequeueReusableCell(withIdentifier: LeaderboardCell.cellID,
                                                       for: indexPath) as! LeaderboardCell
        cell.setUsername(username: presenter.getUsernameFor(index: indexPath.row))
        cell.setRank(rank: indexPath.row+1)
        cell.setScore(score: presenter.getScoreFor(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let playerLabel = Label(text: "Player", font: .PopQuizDefaultFonts.bodyLight, textAlignment: .left)
        let scoreLabel = Label(text: "Score", font: .PopQuizDefaultFonts.bodyLight, textAlignment: .right)
        
        container.addSubview(playerLabel)
        container.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([playerLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10),
                                     playerLabel.widthAnchor.constraint(equalToConstant: 150),
                                     playerLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)])
        
        NSLayoutConstraint.activate([scoreLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10),
                                     scoreLabel.widthAnchor.constraint(equalToConstant: 150),
                                     scoreLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)])
        
        return container
    }
}
