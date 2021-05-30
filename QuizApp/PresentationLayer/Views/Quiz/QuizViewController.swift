//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 05.05.2021..
//

import UIKit

class QuizViewController: UIPageViewController, QuizDelegate {
    var presenter: QuizPresenterProtocol!
    
    private var controllers: [UIViewController] = []
    private var questionIndex = 0
    private var correctAnswers = 0
    
    private var quizIndexLabel: Label!
    private var progressView: ProgressStackView!
    
    private var timeStarted: CFAbsoluteTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .DefaultStrings.appTitle
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
        
        guard let firstQuestionVC = controllers.first else { return }
        let pageAppearance = UIPageControl.appearance()
        pageAppearance.isHidden = true
        
        setViewControllers([firstQuestionVC], direction: .forward, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timeStarted = CFAbsoluteTimeGetCurrent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setQuiz(quiz: QuizViewModel) {
        for question in quiz.questions {
            let questionVC = QuestionViewController(question: question)
            questionVC.pageVC = self
            controllers.append(questionVC)
        }
    }
}

private extension QuizViewController {
    
    func initializeUIComponents() {
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
    
    func addSubviews() {
        view.addSubview(quizIndexLabel)
        view.addSubview(progressView)
    }
    
    func setUpLayout() {
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

extension QuizViewController {
    
    func questionAnswered(correctlyAnswered: Bool) {
        if correctlyAnswered {
            progressView.colorSubview(at: questionIndex, color: UIColor.PopQuizPalette.green, animationDuration: 0.3)
            correctAnswers += 1
        } else {
            progressView.colorSubview(at: questionIndex, color: UIColor.PopQuizPalette.red, animationDuration: 0.3)
        }
        questionIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if self.questionIndex < self.controllers.count {
                self.updateUIComponents()
                self.setViewControllers([self.controllers[self.questionIndex]],
                                        direction: .forward, animated: true,
                                        completion: nil)
            }
            else {
                self.presenter.handleFinishedQuiz(correctAnswers: self.correctAnswers,
                                                  elapsedTime: CFAbsoluteTimeGetCurrent() - self.timeStarted)
            }
        })
    }
    
    @objc
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
}
