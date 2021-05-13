//
//  QuizPresenterProtocol.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizPresenterProtocol: Presenter {
    var coordinator: QuizzesCoordinator? { get set }
    var dataService: NetworkServiceProtocol { get }
    var delegate: QuizDelegate { get }
    
    var quiz: Quiz { get }
    
    func handleFinishedQuiz(correctAnswers: Int, elapsedTime: CFAbsoluteTime)
    func getNoOfQuestions() -> (Int)
}
