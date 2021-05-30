//
//  SettingsViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension SettingsViewController {
    
    func buildViews() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
        setUpActions()
    }
    
    private func initializeUIComponents() {
        usernameTag = Label(text: "USERNAME",
                            font: UIFont.PopQuizDefaultFonts.bodyLight,
                            textAlignment: .left)
        usernameLabel = Label(text: presenter.fetchUsername(),
                              font: UIFont.PopQuizDefaultFonts.heading2,
                              textAlignment: .left)
        logOutButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold,
                              title: "Log Out",
                              textColor: UIColor.PopQuizPalette.red,
                              backgroundColor: UIColor.white)
    }
    
    private func addSubviews() {
        view.addSubview(usernameTag)
        view.addSubview(usernameLabel)
        view.addSubview(logOutButton)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([usernameTag.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
                                     usernameTag.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                                     usernameTag.widthAnchor.constraint(equalToConstant: 100),
                                     usernameTag.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([usernameLabel.leftAnchor.constraint(equalTo: usernameTag.leftAnchor),
                                     usernameLabel.topAnchor.constraint(equalTo: usernameTag.bottomAnchor),
                                     usernameLabel.widthAnchor.constraint(equalToConstant: 300),
                                     usernameLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate([logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
                                     logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logOutButton.widthAnchor.constraint(equalToConstant: 300),
                                     logOutButton.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    private func setUpActions() {
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }

}
