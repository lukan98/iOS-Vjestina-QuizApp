//
//  SettingsPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol SettingsPresenterProtocol {
    var coordinator: QuizzesCoordinator? { get set }
    var dataService: DataServiceProtocol { get }
    var delegate: SettingsDelegate { get }
    
    func fetchUsername() -> (String)
    func handleLogout()
}
