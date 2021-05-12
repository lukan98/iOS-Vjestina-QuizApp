//
//  QuizzesCoordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

protocol QuizzesCoordinator : Coordinator {
    
    func handleQuizSelection(quiz selectedQuiz: Quiz)
    func handleQuizFinished(correctAnswers: Int, quiz: Quiz)
    func handleReviewFinished()
    func handleLogOut()
    func handleGoToLeaderboard(quiz: Quiz)
    
}
