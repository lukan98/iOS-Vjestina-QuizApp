//
//  MainCoordinator+Transitions.swift
//  QuizApp
//
//  Created by Luka Namačinski on 02.06.2021..
//

import Foundation
import UIKit

extension MainCoordinator: UINavigationControllerDelegate {    
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if let _ = fromVC as? LoginViewController,
           let _ = toVC as? UITabBarController {
            return TransitionAnimator()
        } else {
            return nil
        }
    }
    
}
