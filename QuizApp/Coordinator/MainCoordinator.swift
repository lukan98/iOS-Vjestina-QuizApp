//
//  LoginCoordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Event) {
        switch type {
        case .LoginSuccess:
            var quizzesVC: UIViewController & Coordinating  = QuizzesViewController()
            quizzesVC.coordinator = self
            navigationController?.pushViewController(quizzesVC, animated: true)
        }
    }
    
    func start() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
        
        var loginVC: UIViewController & Coordinating = LoginViewController()
        loginVC.coordinator = self
        navigationController?.setViewControllers([loginVC], animated: false)
    }
}
