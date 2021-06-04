//
//  SettingsPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol SettingsPresenterProtocol {
    func fetchUsername() -> (String)
    func handleLogout()
}
