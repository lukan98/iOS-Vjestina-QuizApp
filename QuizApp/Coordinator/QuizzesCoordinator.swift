//
//  QuizzesCoordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit


protocol QuizzesCoordinator {
    
    func handleQuizSelection(quiz selectedQuiz: Quiz)
    
    func handleQuizFinished(correctAnswers: Int, outOf: Int)
    
    func handleQuizReviewFinished()
    
    func handleLogOut(window: UIWindow)
    
    func handleLeaderboard()
}
