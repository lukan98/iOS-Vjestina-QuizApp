//
//  LeaderboardDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol LeaderboardDelegate: Delegate {
    var presenter: LeaderboardPresenterProtocol! { get set }
    
    func showError()
    func showTable()
}
