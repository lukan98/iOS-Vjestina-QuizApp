//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.05.2021..
//

import UIKit

class LeaderboardViewController: UIViewController, LeaderboardDelegate {
    var presenter: LeaderboardPresenterProtocol!
    
    private var titleLabel: Label!
    private var exitButton: UIImageView!
    
    private var errorMessage: Label!
    
    private var leaderboardView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leaderboard"
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
        presenter.fetchAndSortLeaderboard()
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
}

private extension LeaderboardViewController {
    
    func initializeUIComponents() {
        titleLabel = Label(text: "Leaderboard", font: .PopQuizDefaultFonts.heading2, textAlignment: .center)
        
        errorMessage = Label(text: "The leaderboard couldn't be reached",
                             font: .PopQuizDefaultFonts.bodyBold,
                             textAlignment: .center)
        errorMessage.numberOfLines = 0
        errorMessage.isHidden = true
        
        exitButton = UIImageView(image: UIImage(named: .SymbolStrings.exit))
        exitButton.tintColor = .white
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        exitButton.isUserInteractionEnabled = true

        initializeLeaderboardView()
    }
    
    func initializeLeaderboardView() {
        leaderboardView = {
            let tableView = UITableView(frame: CGRect(), style: .grouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .init(white: 1, alpha: 0)
            tableView.separatorColor = .white
            return tableView
        }()
        leaderboardView.delegate = self
        leaderboardView.dataSource = self
        leaderboardView.register(LeaderboardCell.self, forCellReuseIdentifier: LeaderboardCell.cellID)
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(exitButton)
        view.addSubview(leaderboardView)
        view.addSubview(errorMessage)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                                     titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 20),
                                     titleLabel.widthAnchor.constraint(equalToConstant: 150)])
        
        NSLayoutConstraint.activate([exitButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
                                     exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                                     exitButton.widthAnchor.constraint(equalToConstant: 20),
                                     exitButton.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([leaderboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     leaderboardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                                     leaderboardView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     leaderboardView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([errorMessage.widthAnchor.constraint(equalToConstant: 300),
                                     errorMessage.heightAnchor.constraint(equalToConstant: 60),
                                     errorMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
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

private extension LeaderboardViewController {
    
    @objc
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
}
