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
    func handleLogin(window: UIWindow) {
        let newNavigationController = UINavigationController(navigationBarClass: NavBar.self, toolbarClass: nil)
        self.navigationController = newNavigationController
        window.rootViewController = self.navigationController
        
        let tabBarController = UITabBarController()
        tabBarController.styleTabBar()
        
        let quizzesVC = QuizzesViewController()
        let settingsVC = SettingsViewController()
        
        quizzesVC.coordinator = self
        settingsVC.coordinator = self
        
        styleTabIcons(quizzesVC: quizzesVC, settingsVC: settingsVC)
        
        tabBarController.viewControllers = [quizzesVC, settingsVC]
        navigationController.pushViewController(tabBarController, animated: true)
        tabBarController.navigationController?.isNavigationBarHidden = true
    }
    
    private func styleTabIcons(quizzesVC qvc: QuizzesViewController, settingsVC svc: SettingsViewController) {
        qvc.tabBarItem = UITabBarItem(title:"Quiz", image: UIImage(named: "QuizIconSelected"),
                                      selectedImage: UIImage(named: "QuizIconSelected"))
        svc.tabBarItem = UITabBarItem(title:"Settings", image: UIImage(named: "SettingsCog"),
                                      selectedImage: UIImage(named: "SettingsCog"))
    }
}

extension MainCoordinator: QuizzesCoordinator {
    
    func handleLogOut(window: UIWindow) {
        let newNavigationController = UINavigationController(navigationBarClass: NavBar.self, toolbarClass: nil)
        self.navigationController = newNavigationController
        window.rootViewController = self.navigationController
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
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
