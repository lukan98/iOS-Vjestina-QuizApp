//
//  QuizPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizPresenterProtocol: Presenter {
    func handleFinishedQuiz(correctAnswers: Int, elapsedTime: CFAbsoluteTime)
    func getNoOfQuestions() -> (Int)
}
