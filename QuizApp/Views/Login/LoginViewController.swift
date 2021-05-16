//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginDelegate {
    var presenter: LoginPresenterProtocol!
    
    private var appTitle: Label!
    private var emailField: TextField!
    private var passwordField: TextField!
    private var signInButton: Button!
    private var errorMessage: ErrorLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorBackground()
        initializeUIComponents()
        setUpActions()
        addSubviews()
        setUpLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

private extension LoginViewController {
    
    func initializeUIComponents() {
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
        presenter?.handleLogin(username: emailField.text!, password: passwordField.text!)
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

extension LoginViewController {
    func handleSignInError(errorMessage error: String) {
        errorMessage.text = error
        showError()
    }
}
