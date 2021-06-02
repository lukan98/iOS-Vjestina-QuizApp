//
//  TransitionAnimator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 02.06.2021..
//

import Foundation
import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromVC = transitionContext.viewController(forKey: .from) as? LoginViewController,
           let toVC = transitionContext.viewController(forKey: .to) as? UITabBarController
        {
            animateIn(fromVC: fromVC, toVC: toVC, in: transitionContext)
        } else {
            transitionContext.completeTransition(false)
            return
        }
    }
    
    private func animateIn(fromVC: LoginViewController, toVC: UITabBarController,
                           in transitionContext: UIViewControllerContextTransitioning,
                           animationDuration: Double = 1.5,
                           animationDelay: Double = 0.25) -> Void {
        guard let selectedVC = toVC.selectedViewController as? QuizzesViewController else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.applyBackgroundGradient()
        
        containerView.addSubview(toVC.view)
        
        let appTitleCopy = Label(fromVC.appTitle)
        containerView.addSubview(appTitleCopy)
        appTitleCopy.frame = fromVC.view.convert(fromVC.appTitle.frame, to: containerView)
        
        let emailFieldCopy = TextField(fromVC.emailField)
        containerView.addSubview(emailFieldCopy)
        emailFieldCopy.frame = fromVC.view.convert(fromVC.emailField.frame, to: containerView)
        
        let passwordFieldCopy = TextField(fromVC.passwordField)
        containerView.addSubview(passwordFieldCopy)
        passwordFieldCopy.frame = fromVC.view.convert(fromVC.passwordField.frame, to: containerView)
        
        let signInButtonCopy = Button(fromVC.signInButton)
        containerView.addSubview(signInButtonCopy)
        signInButtonCopy.frame = fromVC.view.convert(fromVC.signInButton.frame, to: containerView)
        
        fromVC.appTitle.isHidden = true
        fromVC.emailField.isHidden = true
        fromVC.passwordField.isHidden = true
        fromVC.signInButton.isHidden = true
        
        toVC.view.alpha = 0
        
        selectedVC.view.layoutIfNeeded()
        
        let uiElements = [appTitleCopy, emailFieldCopy, passwordFieldCopy, signInButtonCopy]
        
        for (index, element) in uiElements.enumerated() {
            UIView.animate(withDuration: animationDuration,
                           delay: animationDelay*Double(index),
                           animations: {
                            element.transform = appTitleCopy.transform.translatedBy(x: 0, y: -containerView.frame.height)
                           })
        }
        
        UIView.animate(withDuration: animationDuration,
                       delay: animationDelay*Double(uiElements.count),
                       animations: {
                        toVC.view.alpha = 1
                       },
                       completion: { _ in
                        appTitleCopy.removeFromSuperview()
                        emailFieldCopy.removeFromSuperview()
                        passwordFieldCopy.removeFromSuperview()
                        signInButtonCopy.removeFromSuperview()
                        
                        fromVC.view.removeFromSuperview()
                        
                        transitionContext.completeTransition(true)
                       })
    }
}
