//
//  SettingsPresenter.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

class SettingsPresenter: SettingsPresenterProtocol {
    weak var coordinator: QuizzesCoordinator?
    let dataService: NetworkServiceProtocol = NetworkService.shared
    weak var delegate: SettingsDelegate?
    
    init(delegate sd: SettingsDelegate, coordinator qc: QuizzesCoordinator) {
        self.delegate = sd
        self.coordinator = qc
    }
    
    func fetchUsername() -> (String) {
        return "SportJunkie1234"
    }
    
    func handleLogout() {
        UserCredentialsService.removeUserCredentials()
        coordinator?.handleLogOut()
    }
}
