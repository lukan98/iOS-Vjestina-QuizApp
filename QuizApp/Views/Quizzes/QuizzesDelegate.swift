//
//  QuizzesDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizzesDelegate: Delegate {   
    func showQuizzes()
    func showError()
    func setErrorMessage(message: String)
    func reloadTable()
    func setFunFact(funFact: String)
}
