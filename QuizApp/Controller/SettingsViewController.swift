//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 06.05.2021..
//

import UIKit

class SettingsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private var usernameTag: Label!
    private var usernameLabel: Label!
    private var username: String = "SportJunkie1234"
    
    private var logOutButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
        setUpActions()
    }
    
    private func initializeUIComponents() {
        usernameTag = Label(text: "USERNAME", font: UIFont.PopQuizTheme.bodyLight, textAlignment: .left)
        usernameLabel = Label(text: username, font: UIFont.PopQuizTheme.heading2, textAlignment: .left)
        logOutButton = Button(font: UIFont.PopQuizTheme.bodyBold,
                              title: "Log Out",
                              textColor: UIColor.PopQuizTheme.red,
                              backgroundColor: UIColor.PopQuizTheme.white)
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

private extension SettingsViewController {
    
    @objc
    func logOut() {
        coordinator?.handleLogOut(window: self.view.window!)
    }
    
}
