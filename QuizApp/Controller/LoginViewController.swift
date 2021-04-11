//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private let appLabel: AppTitleLabel = AppTitleLabel(frame: CGRect(), text: Utils.appTitle)
    private let emailField: TextField =  {
        let field = TextField(frame: CGRect(), placeholderText: Utils.emailPlaceholder, isSecure: false)
        field.autocorrectionType = UITextAutocorrectionType.no
        field.autocapitalizationType = UITextAutocapitalizationType.none
        return field
    }()
    private let passwordField: TextField = TextField(frame: CGRect(), placeholderText: Utils.passwordPlaceholder, isSecure: true)
    private let signInButton: AppButton = AppButton(frame: CGRect(), title: Utils.signInString)
    private let errorMessage: AppErrorLabel = {
        let errorLabel = AppErrorLabel(frame: CGRect(), text: Utils.signInFail)
        errorLabel.isHidden = true
        return errorLabel
    } ()
    
    private let dataService: DataServiceProtocol = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
        colorBackground()
        setUpActions()
        addSubviews()
        setUpLayout()
    }
    
}

private extension LoginViewController {
    
    private func colorBackground() {
        self.view.setGradientColor(colorOne: UIColor.AppTheme.purpleLight, colorTwo: UIColor.AppTheme.purpleDark)
    }
    
    private func addSubviews() {
        view.addSubview(appLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(errorMessage)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([appLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
        
        NSLayoutConstraint.activate([errorMessage.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
                                     errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     errorMessage.heightAnchor.constraint(equalTo: passwordField.heightAnchor, multiplier: 1.2),
                                     errorMessage.widthAnchor.constraint(equalTo: passwordField.widthAnchor)])
    }
    
}

private extension LoginViewController {
    
    private func setUpActions() {
        signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        emailField.addTarget(self, action: #selector(hideError), for: .allTouchEvents)
        passwordField.addTarget(self, action: #selector(hideError), for: .allTouchEvents)
    }
    
    @objc
    private func signInAction() {
        let result: LoginStatus = dataService.login(email: self.emailField.text!, password: self.passwordField.text!)
        switch result {
        case LoginStatus.success:
            print("Sign in successful!")
        case LoginStatus.error:
            print("Sign in failure")
            showError()
        }
    }
    
    @objc
    private func showError() {
        errorMessage.isHidden = false
    }
    
    @objc
    private func hideError() {
        errorMessage.isHidden = true
    }
    
}
