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
    
    var appTitle: Label!
    var emailField: TextField!
    var passwordField: TextField!
    var signInButton: Button!
    var errorMessage: ErrorLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setUpActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        guard let username = emailField.text, let password = passwordField.text else { return }
        presenter?.handleLogin(username: username, password: password)
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
