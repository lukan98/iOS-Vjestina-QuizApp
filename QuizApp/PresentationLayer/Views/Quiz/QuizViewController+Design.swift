//
//  QuizViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension QuizViewController {
    
    func buildViews() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
    
    private func initializeUIComponents() {
        quizIndexLabel = Label(text: "", font: UIFont.PopQuizDefaultFonts.bodyBold, textAlignment: .left)
        progressView = ProgressStackView(noOfSegments: presenter.getNoOfQuestions())
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: .SymbolStrings.back),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(goBack))
        
        updateUIComponents()
    }
    
    func updateUIComponents() {
        quizIndexLabel.text = "\(questionIndex+1)/\(presenter.getNoOfQuestions())"
        progressView.colorSubview(at: questionIndex, color: UIColor.white)
    }
    
    private func addSubviews() {
        view.addSubview(quizIndexLabel)
        view.addSubview(progressView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([quizIndexLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     quizIndexLabel.heightAnchor.constraint(equalToConstant: 15),
                                     quizIndexLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
                                     quizIndexLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([progressView.topAnchor.constraint(equalTo: quizIndexLabel.bottomAnchor, constant: 5),
                                     progressView.heightAnchor.constraint(equalToConstant: 5),
                                     progressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
                                     progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        for subview in progressView.arrangedSubviews {
            NSLayoutConstraint.activate([subview.widthAnchor.constraint(equalTo: progressView.widthAnchor,
                                                                        multiplier: CGFloat(1/Double(1+presenter.getNoOfQuestions())))])
        }
    }
    
}

