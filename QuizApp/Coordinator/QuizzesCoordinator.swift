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
        let quizVC = QuizViewController(quiz: selectedQuiz)
        quizVC.coordinator = self
        navigationController.pushViewController(quizVC, animated: true)
    }
    
    func handleQuizFinished() {
        let quizResultVC = QuizResultViewController()
        navigationController.pushViewController(quizResultVC, animated: true)
    }
}
