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
        let loginPresenter = LoginPresenter(delegate: loginVC, coordinator: self)
        loginVC.presenter = loginPresenter
        navigationController.pushViewController(loginVC, animated: false)
    }
}

extension MainCoordinator: LoginCoordinator {
    func handleLogin() {
        let tabBarController = UITabBarController()
        tabBarController.styleTabBar()
        
        let quizzesVC = QuizzesViewController()
        let quizzesPresenter = QuizzesPresenter(delegate: quizzesVC, coordinator: self)
        quizzesVC.presenter = quizzesPresenter
        
        let settingsVC = SettingsViewController()
        
        settingsVC.coordinator = self
        
        styleTabIcons(quizzesVC: quizzesVC, settingsVC: settingsVC)
        
        tabBarController.viewControllers = [quizzesVC, settingsVC]
        navigationController.setViewControllers([tabBarController], animated: true)
        tabBarController.navigationController?.isNavigationBarHidden = true
    }
    
    private func styleTabIcons(quizzesVC qvc: QuizzesViewController, settingsVC svc: SettingsViewController) {
        qvc.tabBarItem = UITabBarItem(title:"Quiz", image: UIImage(named: .SymbolStrings.quizIcon),
                                      selectedImage: UIImage(named: .SymbolStrings.quizIcon))
        svc.tabBarItem = UITabBarItem(title:"Settings", image: UIImage(named: .SymbolStrings.settings),
                                      selectedImage: UIImage(named: .SymbolStrings.settings))
    }
}

extension MainCoordinator: QuizzesCoordinator {
    
    func handleLeaderboard() {
        let leaderboardVC = LeaderboardViewController()
        leaderboardVC.coordinator = self
        navigationController.present(leaderboardVC, animated: true, completion: nil)
    }
    
    func handleLogOut() {
        let loginVC = LoginViewController()
        let loginPresenter = LoginPresenter(delegate: loginVC, coordinator: self)
        loginVC.presenter = loginPresenter
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    func handleQuizFinished(correctAnswers: Int, outOf: Int) {
        let quizResultVC = QuizResultViewController(correctAnswers: correctAnswers, outOf: outOf)
        quizResultVC.coordinator = self
        navigationController.pushViewController(quizResultVC, animated: true)
    }
    
    func handleQuizReviewFinished() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func handleQuizSelection(quiz selectedQuiz: Quiz) {
        let quizVC = QuizViewController(quiz: selectedQuiz)
        quizVC.coordinator = self
        navigationController.pushViewController(quizVC, animated: true)
    }
    
}
