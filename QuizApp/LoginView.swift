//
//  LoginView.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

class LoginView: UIView {
    
    private var appLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 30, height: 30))
        label.text = "QuizApp"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var emailField: UITextField = {
        let textField = UITextField()
        textField.text = "Enter your email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private var passwordField: UITextField = {
        let textField = UITextField()
        textField.text = "Enter your password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        backgroundColor = .purple
        
        appLabel.backgroundColor = .white
        appLabel.textAlignment = .center
        addSubview(appLabel)
        
        emailField.backgroundColor = .white
        emailField.textAlignment = .left
        addSubview(emailField)
        
        passwordField.backgroundColor = .white
        passwordField.textAlignment = .left
        addSubview(passwordField)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([appLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
                                     appLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     appLabel.heightAnchor.constraint(equalToConstant: 50),
                                     appLabel.widthAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([emailField.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 100),
                                     emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     emailField.heightAnchor.constraint(equalToConstant: 50),
                                     emailField.widthAnchor.constraint(equalToConstant: 200)])
        
        NSLayoutConstraint.activate([passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 100),
                                     passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     passwordField.heightAnchor.constraint(equalToConstant: 50),
                                     passwordField.widthAnchor.constraint(equalToConstant: 200)])
    }
    
}
