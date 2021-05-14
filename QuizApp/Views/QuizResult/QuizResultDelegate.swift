//
//  QuizResultDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizResultDelegate: Delegate { 
    func setResultLabel(correctAnswers correct: Int, totalQuestions total: Int)
}
