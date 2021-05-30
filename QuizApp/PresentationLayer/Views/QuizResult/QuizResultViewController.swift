//
//  QuizResultViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 05.05.2021..
//

import UIKit

class QuizResultViewController: UIViewController, QuizResultDelegate {
    var presenter: QuizResultPresenterProtocol!
    
    var resultLabel: Label!
    var finishButton: Button!
    var leaderboardButton: Button!

    var correctAnswers: Int!
    var totalQuestions: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setResultLabel(correctAnswers correct: Int, totalQuestions total: Int) {
        correctAnswers = correct
        totalQuestions = total
    }
    
    @objc
    func finishReview() {
        presenter.handleReviewFinished()
    }
    
    @objc
    func goToLeaderboard() {
        presenter.handleGoToLeaderboard()
    }
}
