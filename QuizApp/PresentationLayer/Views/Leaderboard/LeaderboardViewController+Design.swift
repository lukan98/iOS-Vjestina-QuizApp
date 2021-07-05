//
//  LeaderboardViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension LeaderboardViewController {
    
    func buildViews() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
    
    private func initializeUIComponents() {
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
    
    private func initializeLeaderboardView() {
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
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(exitButton)
        view.addSubview(leaderboardView)
        view.addSubview(errorMessage)
    }
    
    private func setUpLayout() {
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
