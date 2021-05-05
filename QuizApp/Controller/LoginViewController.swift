//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private var appTitle: PopQuizLabel!
    private var emailField: PopQuizTextField!
    private var passwordField: PopQuizTextField!
    private var signInButton: PopQuizButton!
    private var errorMessage: PopQuizErrorLabel!
    
    private let dataService: DataServiceProtocol = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorBackground()
        initializeUIComponents()
        setUpActions()
        addSubviews()
        setUpLayout()
    }
    
}

private extension LoginViewController {
    
    func initializeUIComponents() {
        appTitle = PopQuizLabel(text: Utils.defaultStrings.appTitle, font: UIFont.PopQuizTheme.title)
        emailField =  {
            let field = PopQuizTextField(font: UIFont.PopQuizTheme.bodyLight, placeholderText: Utils.defaultStrings.emailPlaceholder, isSecure: false)
            field.autocorrectionType = UITextAutocorrectionType.no
            field.autocapitalizationType = UITextAutocapitalizationType.none
            return field
        }()
        passwordField = PopQuizTextField(font: UIFont.PopQuizTheme.bodyLight, placeholderText: Utils.defaultStrings.passwordPlaceholder, isSecure: true)
        signInButton = PopQuizButton(font: UIFont.PopQuizTheme.bodyBold, title: Utils.defaultStrings.signInString)
        errorMessage = PopQuizErrorLabel(font: UIFont.PopQuizTheme.heading3, text: Utils.defaultStrings.signInFail)
        errorMessage.isHidden = true

    }
    
}

private extension LoginViewController {
    
    func addSubviews() {
        view.addSubview(appTitle)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(errorMessage)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.topAnchor),
                                     appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
                                     appTitle.widthAnchor.constraint(greaterThanOrEqualToConstant: 140)])
        
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
    
    func setUpActions() {
        signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        emailField.addTarget(self, action: #selector(hideError), for: .allTouchEvents)
        passwordField.addTarget(self, action: #selector(hideError), for: .allTouchEvents)
        emailField.addTarget(emailField, action: #selector(emailField.setBorder), for: .editingDidBegin)
        emailField.addTarget(emailField, action: #selector(emailField.hideBorder), for: .editingDidEnd)
        passwordField.addTarget(passwordField, action: #selector(passwordField.setBorder), for: .editingDidBegin)
        passwordField.addTarget(passwordField, action: #selector(passwordField.hideBorder), for: .editingDidEnd)
    }
    
    @objc
    func signInAction() {
        let result: LoginStatus = dataService.login(email: self.emailField.text!, password: self.passwordField.text!)
        switch result {
        case LoginStatus.success:
            print("Sign in successful!")
            coordinator?.handleSignIn()
        case LoginStatus.error:
            print("Sign in failure")
            showError()
        }
    }
    
    @objc
    func showError() {
        errorMessage.isHidden = false
    }
    
    @objc
    func hideError() {
        errorMessage.isHidden = true
    }
}
