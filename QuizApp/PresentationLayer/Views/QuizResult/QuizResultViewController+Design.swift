//
//  QuizResultViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension QuizResultViewController {
    
    func buildViews() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpActions()
        setUpLayout()
    }
    
    private func addSubviews() {
        view.addSubview(resultLabel)
        view.addSubview(finishButton)
        view.addSubview(leaderboardButton)
    }
    
    private func initializeUIComponents() {
        resultLabel = Label(text: "\(correctAnswers!)/\(totalQuestions!)",
                            font: UIFont.PopQuizDefaultFonts.title, textAlignment: .center)
        finishButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold, title: "Finish Quiz")
        leaderboardButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold, title: "See Leaderboard")
        
        navigationItem.hidesBackButton = true
    }
    
    private func setUpActions() {
        finishButton.addTarget(self, action: #selector(finishReview), for: .touchUpInside)
        leaderboardButton.addTarget(self, action: #selector(goToLeaderboard), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([resultLabel.widthAnchor.constraint(equalToConstant: 200),
                                     resultLabel.heightAnchor.constraint(equalToConstant: 110),
                                     resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,
                                                                          constant: -20)])

        NSLayoutConstraint.activate([finishButton.widthAnchor.constraint(equalToConstant: 300),
                                     finishButton.heightAnchor.constraint(equalToConstant: 45),
                                     finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                          constant: -40),
                                     finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([leaderboardButton.widthAnchor.constraint(equalTo: finishButton.widthAnchor),
                                     leaderboardButton.heightAnchor.constraint(equalTo: finishButton.heightAnchor),
                                     leaderboardButton.bottomAnchor.constraint(equalTo: finishButton.topAnchor,
                                                                               constant: -20),
                                     leaderboardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
}
