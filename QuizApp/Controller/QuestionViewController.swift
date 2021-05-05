//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

class QuestionViewController: UIViewController {
    weak var pageVC: QuizViewController?
    
    private var question: Question!
    private var questionCountLabel: PopQuizLabel!
    private var questionLabel: PopQuizLabel!
    private var answerButtonStack: UIStackView!
    private var progressView: UIProgressView!
    
    init(question: Question) {
        super.init(nibName: nil, bundle: nil)
        self.question = question
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = Utils.defaultStrings.appTitle
        view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .clear
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
}

private extension QuestionViewController {
    
    func initializeUIComponents() {
        questionCountLabel = PopQuizLabel(text: "1/5", font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
        questionLabel = PopQuizLabel(text: question.question, font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
        answerButtonStack = {
            let view = UIStackView()
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.distribution = .equalSpacing
            for i in 0..<question.answers.count {
                let answerButton = PopQuizButton(font: UIFont.PopQuizTheme.bodyBold,
                                                 title: question.answers[i],
                                                 textColor: UIColor.PopQuizTheme.white,
                                                 backgroundColor: UIColor.PopQuizTheme.whiteWithTransparency)
                answerButton.addTarget(self, action: #selector(submitAnswer), for: .touchUpInside)
                answerButton.tag = i
                view.addArrangedSubview(answerButton)
            }
            return view
        }()
        progressView = {
            let view = UIProgressView(progressViewStyle: .default)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    }
}

private extension QuestionViewController {
    
    func addSubviews() {
        view.addSubview(questionCountLabel)
        view.addSubview(questionLabel)
        view.addSubview(answerButtonStack)
        view.addSubview(progressView)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([questionCountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
                                     questionCountLabel.heightAnchor.constraint(equalToConstant: 15),
                                     questionCountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
                                     questionCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([progressView.topAnchor.constraint(equalTo: questionCountLabel.bottomAnchor, constant: 10),
                                     progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     progressView.widthAnchor.constraint(equalTo: questionCountLabel.widthAnchor),
                                     progressView.heightAnchor.constraint(equalToConstant: 5)])
        
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
            print("Correct")
            sender.backgroundColor = UIColor.PopQuizTheme.green
        }
        else {
            print("Incorrect")
            sender.backgroundColor = UIColor.PopQuizTheme.red
            answerButtonStack.arrangedSubviews[question.correctAnswer].backgroundColor = UIColor.PopQuizTheme.green
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.pageVC?.showNextQuestion()
        }
    }
}
