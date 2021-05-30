//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

class QuestionViewController: UIViewController {
    weak var pageVC: QuizViewController?
    var question: QuestionViewModel!
    
    var questionLabel: Label!
    var answerButtonStack: UIStackView!
    
    init(question: QuestionViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.question = question
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        buildViews()
    }
}

extension QuestionViewController {
    
    @objc
    func submitAnswer(sender: UIButton!) {
        answerButtonStack.isUserInteractionEnabled = false
        if (sender.tag == question.correctAnswer) {
            sender.backgroundColor = UIColor.PopQuizPalette.green
        }
        else {
            sender.backgroundColor = UIColor.PopQuizPalette.red
            answerButtonStack.arrangedSubviews[question.correctAnswer].backgroundColor = UIColor.PopQuizPalette.green
        }
        self.pageVC?.questionAnswered(correctlyAnswered: sender.tag == question.correctAnswer)
    }
}
