//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private let appLabel: AppLabel = AppLabel(frame: CGRect(), text: Utils.appTitle)
    private let emailField: TextField = TextField(frame: CGRect(), placeholderText: Utils.emailPlaceholder, isSecure: false)
    private let passwordField: TextField = TextField(frame: CGRect(), placeholderText: Utils.passwordPlaceholder, isSecure: true)
    private let signInButton: AppButton = AppButton(frame: CGRect(), title: Utils.signInString)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height))
        colorBackground()
        addSubviews()
        setUpLayout()
    }
    
    private func colorBackground() {
        self.view.setGradientColor(colorOne: UIColor.AppTheme.purpleLight, colorTwo: UIColor.AppTheme.purpleDark)
    }
    
    private func addSubviews() {
        view.addSubview(appLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
                                     appLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appLabel.heightAnchor.constraint(equalToConstant: 50),
                                     appLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 140)])
        
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
    }
    
}
