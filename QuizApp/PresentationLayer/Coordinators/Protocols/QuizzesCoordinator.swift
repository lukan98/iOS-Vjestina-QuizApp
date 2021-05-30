//
//  QuizzesCoordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

protocol QuizzesCoordinator : Coordinator {
    
    func handleQuizSelection(quiz selectedQuiz: QuizViewModel)
    func handleQuizFinished(correctAnswers: Int, elapsedTime: CFAbsoluteTime, quiz: QuizViewModel)
    func handleReviewFinished()
    func handleLogOut()
    func handleGoToLeaderboard(quiz: Quiz)
    
}
