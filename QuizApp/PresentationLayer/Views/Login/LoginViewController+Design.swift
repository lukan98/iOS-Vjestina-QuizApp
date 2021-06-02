//
//  LoginViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension LoginViewController {
    
    func buildViews() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
    
    private func initializeUIComponents() {
        appTitle = Label(text: .DefaultStrings.appTitle, font: UIFont.PopQuizDefaultFonts.title)
        emailField =  {
            let field = TextField(font: UIFont.PopQuizDefaultFonts.bodyLight,
                                  placeholderText: .DefaultStrings.emailPlaceholder,
                                  isSecure: false)
            field.autocorrectionType = UITextAutocorrectionType.no
            field.autocapitalizationType = UITextAutocapitalizationType.none
            return field
        }()
        passwordField = TextField(font: UIFont.PopQuizDefaultFonts.bodyLight,
                                  placeholderText: .DefaultStrings.passwordPlaceholder,
                                  isSecure: true)
        signInButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold, title: .DefaultStrings.signInString)
        errorMessage = ErrorLabel(font: UIFont.PopQuizDefaultFonts.bodyBold, text: "")
        errorMessage.numberOfLines = 0
        errorMessage.isHidden = true

    }
    
    private func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(errorMessage)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.topAnchor),
                                     appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTitle.widthAnchor.constraint(greaterThanOrEqualToConstant: 140),
                                     appTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)])
        
        NSLayoutConstraint.activate([emailField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -20),
                                     emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     emailField.heightAnchor.constraint(equalToConstant: 45),
                                     emailField.widthAnchor.constraint(equalToConstant: 300)])
        
        NSLayoutConstraint.activate([passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor),
                                     passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor)])
        
        NSLayoutConstraint.activate([signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
                                     signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     signInButton.heightAnchor.constraint(equalTo: passwordField.heightAnchor),
                                     signInButton.widthAnchor.constraint(equalTo: passwordField.widthAnchor)])
        
        NSLayoutConstraint.activate([errorMessage.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
                                     errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     errorMessage.heightAnchor.constraint(equalTo: passwordField.heightAnchor, multiplier: 1.2),
                                     errorMessage.widthAnchor.constraint(equalTo: passwordField.widthAnchor)])
    }
}

extension LoginViewController {
    
    func entranceAnimations(_ animationDuration: Double, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: options,
                       animations: {
                        self.appTitle.transform = .identity
                        self.appTitle.alpha = 1
                       })
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: options,
                       animations: {
                        self.emailField.transform = .identity
                       })
        UIView.animate(withDuration: animationDuration,
                       delay: 0.25,
                       options: options,
                       animations: {
                        self.passwordField.transform = .identity
                       })
        UIView.animate(withDuration: animationDuration,
                       delay: 0.5,
                       options: options,
                       animations: {
                        self.signInButton.transform = .identity
                       })
    }
    
    func exitAnimations(_ animationDuration: Double = 0.25, options: UIView.AnimationOptions,
                        completionHandler: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: options,
                       animations: {
                        self.appTitle.transform = self.appTitle.transform.translatedBy(x: 0, y: -self.view.frame.height)
                       })
        UIView.animate(withDuration: animationDuration,
                       delay: 0.25,
                       options: options,
                       animations: {
                        self.emailField.transform = self.emailField.transform.translatedBy(x: 0, y: -self.view.frame.height)
                       })
        UIView.animate(withDuration: animationDuration,
                       delay: 0.5,
                       options: options,
                       animations: {
                        self.passwordField.transform = self.passwordField.transform.translatedBy(x: 0, y: -self.view.frame.height)
                       })
        UIView.animate(withDuration: animationDuration,
                       delay: 0.75,
                       options: options,
                       animations: {
                        self.signInButton.transform = self.signInButton.transform.translatedBy(x: 0, y: -self.view.frame.height)
                       },
                       completion: completionHandler)
    }
    
    func animationStartLayout() {
        appTitle.transform = appTitle.transform.scaledBy(x: 0, y: 0)
        appTitle.alpha = 0
        emailField.transform = emailField.transform.translatedBy(x: -view.frame.width, y: 0)
        passwordField.transform = passwordField.transform.translatedBy(x: -view.frame.width, y: 0)
        signInButton.transform = passwordField.transform.translatedBy(x: -view.frame.width, y: 0)
    }
    
}

