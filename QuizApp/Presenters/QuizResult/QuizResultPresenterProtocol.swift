//
//  QuizResultPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizResultPresenterProtocol: Presenter {
    var coordinator: QuizzesCoordinator? { get set }
    var dataService: NetworkServiceProtocol { get }
    var delegate: QuizResultDelegate { get }
    
    func handleGoToLeaderboard()
    func handleReviewFinished()
}
