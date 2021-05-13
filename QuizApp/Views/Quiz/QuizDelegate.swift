//
//  QuizDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol QuizDelegate: Delegate {
    var presenter: QuizPresenterProtocol! { get set }
    
    func setQuiz(quiz: Quiz)
}
