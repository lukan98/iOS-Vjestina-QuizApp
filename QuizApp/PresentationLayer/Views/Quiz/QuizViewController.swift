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
    var questionIndex = 0
    private var correctAnswers = 0
    
    var quizIndexLabel: Label!
    var progressView: ProgressStackView!
    
    private var timeStarted: CFAbsoluteTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .DefaultStrings.appTitle
        buildViews()
        
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
