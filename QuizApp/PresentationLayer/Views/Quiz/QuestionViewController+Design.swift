//
//  QuestionViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension QuestionViewController {
    
    func buildViews() {
        view.backgroundColor = .clear
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
    
    private func initializeUIComponents() {
        questionLabel = Label(text: question.question, font: UIFont.PopQuizDefaultFonts.bodyBold, textAlignment: .left)
        answerButtonStack = {
            let view = UIStackView()
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.distribution = .equalSpacing
            for i in 0..<question.answers.count {
                let answerButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold,
                                                 title: question.answers[i],
                                                 textColor: UIColor.white,
                                                 backgroundColor: UIColor.PopQuizPalette.whiteLessOpaque)
                answerButton.addTarget(self, action: #selector(submitAnswer), for: .touchUpInside)
                answerButton.tag = i
                view.addArrangedSubview(answerButton)
            }
            return view
        }()
    }
    
    private func addSubviews() {
        view.addSubview(questionLabel)
        view.addSubview(answerButtonStack)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([answerButtonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
                                     answerButtonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     answerButtonStack.widthAnchor.constraint(equalToConstant: 330),
                                     answerButtonStack.heightAnchor.constraint(equalToConstant: 210)])
        
        NSLayoutConstraint.activate([questionLabel.bottomAnchor.constraint(equalTo: answerButtonStack.topAnchor, constant: -10),
                                     questionLabel.leftAnchor.constraint(equalTo: answerButtonStack.leftAnchor),
                                     questionLabel.widthAnchor.constraint(equalTo: answerButtonStack.widthAnchor)])
        
        for subview in answerButtonStack.arrangedSubviews {
            NSLayoutConstraint.activate([subview.heightAnchor.constraint(equalToConstant: 45)])
        }
    }
    
}
