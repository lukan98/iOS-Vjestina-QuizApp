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
        
        let quizzesVC = createQuizzesViewController()
        
        let searchVC = createSearchViewController()
        
        let settingsVC = SettingsViewController()
        let settingsPresenter = SettingsPresenter(delegate: settingsVC, coordinator: self)
        settingsVC.presenter = settingsPresenter
        
        styleTabIcons(quizzesVC: quizzesVC, searchVC: searchVC, settingsVC: settingsVC)
        
        tabBarController.viewControllers = [quizzesVC, searchVC, settingsVC]
        navigationController.setViewControllers([tabBarController], animated: true)
        tabBarController.navigationController?.isNavigationBarHidden = true
    }
    
    private func styleTabIcons(quizzesVC: QuizzesViewController, searchVC: SearchViewController, settingsVC: SettingsViewController) {
        quizzesVC.tabBarItem = UITabBarItem(title:"Quiz", image: UIImage(named: .SymbolStrings.quizIcon),
                                            selectedImage: UIImage(named: .SymbolStrings.quizIcon))
        
        searchVC.tabBarItem = UITabBarItem(title:"Search", image: UIImage(named: .SymbolStrings.search),
                                           selectedImage: UIImage(named: .SymbolStrings.search))
        
        settingsVC.tabBarItem = UITabBarItem(title:"Settings", image: UIImage(named: .SymbolStrings.settings),
                                             selectedImage: UIImage(named: .SymbolStrings.settings))
    }
}

extension MainCoordinator: QuizzesCoordinator {
    
    func handleGoToLeaderboard(quiz: Quiz) {
        let leaderboardVC = LeaderboardViewController()
        let leaderboardPresenter = LeaderboardPresenter(delegate: leaderboardVC, coordinator: self, quiz: quiz)
        leaderboardVC.presenter = leaderboardPresenter
        navigationController.present(leaderboardVC, animated: true, completion: nil)
    }
    
    func handleLogOut() {
        let loginVC = LoginViewController()
        let loginPresenter = LoginPresenter(delegate: loginVC, coordinator: self)
        loginVC.presenter = loginPresenter
        navigationController.setViewControllers([loginVC], animated: true)
    }
    
    func handleQuizFinished(correctAnswers: Int, elapsedTime: CFAbsoluteTime, quiz: QuizViewModel) {
        let quizResultVC = QuizResultViewController()
        let quizResultPresenter = QuizResultPresenter(delegate: quizResultVC, coordinator: self,
                                                      quiz: quiz, correctAnswers: correctAnswers,
                                                      elapsedTime: elapsedTime)
        quizResultVC.presenter = quizResultPresenter
        navigationController.pushViewController(quizResultVC, animated: true)
    }
    
    func handleReviewFinished() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func handleQuizSelection(quiz selectedQuiz: QuizViewModel) {
        let quizVC = QuizViewController(transitionStyle: .scroll,
                                        navigationOrientation: .horizontal,
                                        options: .none)
        let quizPresenter = QuizPresenter(delegate: quizVC, coordinator: self, quiz: selectedQuiz)
        quizVC.presenter = quizPresenter
        navigationController.pushViewController(quizVC, animated: true)
    }
    
}

extension MainCoordinator {
    
    private func createQuizzesViewController() -> QuizzesViewController {
        let quizzesVC = QuizzesViewController()
        let coreDataContext = CoreDataStack(modelName: .DefaultStrings.modelName).managedContext
        let quizRepository = QuizRepository(databaseDataSource: QuizDatabaseDataSource(coreDataContext: coreDataContext),
                                            networkDataSource: QuizNetworkDataSource())
        let quizUseCase = QuizUseCase(quizRepository: quizRepository)
        let quizzesPresenter = QuizzesPresenter(delegate: quizzesVC, coordinator: self, quizUseCase: quizUseCase)
        quizzesVC.presenter = quizzesPresenter
        return quizzesVC
    }
    
    private func createSearchViewController() -> SearchViewController {
        let searchVC = SearchViewController()
        let coreDataContext = CoreDataStack(modelName: .DefaultStrings.modelName).managedContext
        let quizRepository = QuizRepository(databaseDataSource: QuizDatabaseDataSource(coreDataContext: coreDataContext),
                                            networkDataSource: QuizNetworkDataSource())
        let quizUseCase = QuizUseCase(quizRepository: quizRepository)
        let searchPresenter = SearchPresenter(delegate: searchVC, coordinator: self, quizUseCase: quizUseCase)
        searchVC.presenter = searchPresenter
        return searchVC
    }
    
}
