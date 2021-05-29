//
//  LeaderboardDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol LeaderboardDelegate: Delegate { 
    func showError()
    func setErrorMessage(message: String)
    func showTable()
    func reloadTable()
}
