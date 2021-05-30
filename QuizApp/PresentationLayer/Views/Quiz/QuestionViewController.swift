//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

class QuestionViewController: UIViewController {
    weak var pageVC: QuizViewController?
    private var question: QuestionViewModel!
    
    private var questionLabel: Label!
    private var answerButtonStack: UIStackView!
    
    init(question: QuestionViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.question = question
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
}

private extension QuestionViewController {
    
    func initializeUIComponents() {
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
}

private extension QuestionViewController {
    
    func addSubviews() {
        view.addSubview(questionLabel)
        view.addSubview(answerButtonStack)
    }
    
    func setUpLayout() {
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

private extension QuestionViewController {
    
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
