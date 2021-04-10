//
//  LoginView.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

class LoginView: UIView {
    
    private let appLabel: AppLabel = {
        let label = AppLabel(frame: CGRect(), text: Utils.appTitle)
        return label
    }()
    private let emailField: TextField = {
        let textField = TextField(frame: CGRect(), placeholderText: Utils.emailPlaceholder, isSecure: false)
        return textField
    }()
    private var passwordField: TextField = {
        let textField = TextField(frame: CGRect(), placeholderText: Utils.passwordPlaceholder, isSecure: true)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.backgroundColor = UIColor.AppTheme.purple
        
        addSubview(appLabel)
        addSubview(emailField)
        addSubview(passwordField)

    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([appLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
                                     appLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     appLabel.heightAnchor.constraint(equalToConstant: 50),
                                     appLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 140)])
        
        NSLayoutConstraint.activate([emailField.topAnchor.constraint(equalTo: appLabel.bottomAnchor, constant: 150),
                                     emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     emailField.heightAnchor.constraint(equalToConstant: 45),
                                     emailField.widthAnchor.constraint(equalToConstant: 300)])
        
        NSLayoutConstraint.activate([passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
                                     passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor),
                                     passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor)])
    }
    
}
