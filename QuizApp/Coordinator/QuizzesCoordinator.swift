//
//  QuizzesCoordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

class QuizzesCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let quizzesVC = QuizzesViewController()
        quizzesVC.coordinator = self
        navigationController.pushViewController(quizzesVC, animated: true)
    }
    
    func handleQuizSelection(quiz selectedQuiz: Quiz) {
        let quizVC = QuizViewController()
        quizVC.coordinator = self
        quizVC.quiz = selectedQuiz
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(quizVC, animated: true)
    }
}
