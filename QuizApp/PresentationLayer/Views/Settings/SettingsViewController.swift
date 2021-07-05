//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 06.05.2021..
//

import UIKit

class SettingsViewController: UIViewController, SettingsDelegate {
    var presenter: SettingsPresenterProtocol!
    
    var usernameTag: Label!
    var usernameLabel: Label!
    
    var logOutButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    @objc
    func logOut() {
        presenter.handleLogout()
    }
    
}
