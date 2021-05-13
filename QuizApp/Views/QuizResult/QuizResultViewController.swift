//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 05.05.2021..
//

import UIKit

class QuizResultViewController: UIViewController, QuizResultDelegate {
    var presenter: QuizResultPresenterProtocol!
    
    private var resultLabel: Label!
    private var finishButton: Button!
    private var leaderboardButton: Button!

    private var correctAnswers: Int!
    private var totalQuestions: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpActions()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setResultLabel(correctAnswers correct: Int, totalQuestions total: Int) {
        correctAnswers = correct
        totalQuestions = total
    }
}

private extension QuizResultViewController {
    
    func addSubviews() {
        view.addSubview(resultLabel)
        view.addSubview(finishButton)
        view.addSubview(leaderboardButton)
    }
    
    func initializeUIComponents() {
        resultLabel = Label(text: "\(correctAnswers!)/\(totalQuestions!)",
                            font: UIFont.PopQuizDefaultFonts.title, textAlignment: .center)
        finishButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold, title: "Finish Quiz")
        leaderboardButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold, title: "See Leaderboard")
        
        navigationItem.hidesBackButton = true
    }
    
    func setUpActions() {
        finishButton.addTarget(self, action: #selector(finishReview), for: .touchUpInside)
        leaderboardButton.addTarget(self, action: #selector(goToLeaderboard), for: .touchUpInside)
    }
    
    func setUpLayout() {
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

private extension QuizResultViewController {
    
    @objc
    func finishReview() {
        presenter.handleReviewFinished()
    }
    
    @objc
    func goToLeaderboard() {
        presenter.handleGoToLeaderboard()
    }
}
