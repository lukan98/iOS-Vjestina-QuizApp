//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 03.05.2021..
//

import UIKit

class QuizViewController: UIViewController {
    weak var coordinator: QuizzesCoordinator?
    var quiz: Quiz?
    private var questionCount: Int!
    private var questionCounter: Int = 1
    
    private var questionCountLabel: PopQuizLabel!
    private var questionLabel: PopQuizLabel!
    private var answerButtonStack: UIStackView!
    private var progressView: UIProgressView!
    
    override func viewDidLoad() {
        self.title = Utils.defaultStrings.appTitle
        questionCount = quiz?.questions.count
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
        colorBackground()
        initializeUIComponents()
        updateUIComponents(questionIndex: questionCounter)
        addSubviews()
        setUpLayout()
    }
}

private extension QuizViewController {
    
    func initializeUIComponents() {
        questionCountLabel = PopQuizLabel(text: "", font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
        questionLabel = PopQuizLabel(text: "", font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
        answerButtonStack = {
            let view = UIStackView()
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.distribution = .equalSpacing
            for _ in 0..<4 {
                let answerButton = PopQuizButton(font: UIFont.PopQuizTheme.bodyBold,
                                                 title: "",
                                                 textColor: UIColor.PopQuizTheme.white,
                                                 backgroundColor: UIColor.PopQuizTheme.whiteWithTransparency)
                answerButton.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
                NSLayoutConstraint.activate([answerButton.heightAnchor.constraint(equalToConstant: 45)])
                view.addArrangedSubview(answerButton)
            }
            return view
        }()
        progressView = {
            let view = UIProgressView(progressViewStyle: .default)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.sizeToFit()
            return view
        }()
    }
    
    func updateUIComponents(questionIndex: Int) {
        questionCountLabel.text = "\(questionIndex)/\(questionCount!)"
        questionLabel.text = quiz!.questions[questionIndex].question
        for i in 0..<answerButtonStack.arrangedSubviews.count {
            let answerButton = answerButtonStack.arrangedSubviews[i] as! PopQuizButton
            answerButton.setTitle(quiz!.questions[questionIndex].answers[i], for: .normal)
        }
    }
    
}

private extension QuizViewController {
    
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
        
    }
}

private extension QuizViewController {
    
    @objc
    func nextQuestion() {
        questionCounter += 1
        updateUIComponents(questionIndex: questionCounter)
    }
}
