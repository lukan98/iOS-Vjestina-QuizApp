//
//  LoginCoordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: false)
    }
}

extension MainCoordinator: LoginCoordinator {
    func handleLogin() {
        let quizzesVC = QuizzesViewController()
        quizzesVC.coordinator = self
        navigationController.pushViewController(quizzesVC, animated: true)
    }
}

extension MainCoordinator: QuizzesCoordinator {
    
    func handleQuizFinished(correctAnswers: Int, outOf: Int) {
        let quizResultVC = QuizResultViewController(correctAnswers: correctAnswers, outOf: outOf)
        quizResultVC.coordinator = self
        navigationController.pushViewController(quizResultVC, animated: true)
    }
    
    func handleQuizReviewFinished() {
        navigationController.popToViewController(ofClass: QuizzesViewController.self, animated: true)
    }
    
    func handleQuizSelection(quiz selectedQuiz: Quiz) {
        let quizVC = QuizViewController(quiz: selectedQuiz)
        quizVC.coordinator = self
        navigationController.pushViewController(quizVC, animated: true)
    }
    
}


