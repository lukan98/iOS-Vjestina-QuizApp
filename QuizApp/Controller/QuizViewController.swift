//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 05.05.2021..
//

import UIKit

class QuizViewController: UIPageViewController {
    weak var coordinator: QuizzesCoordinator?
    
    private var quiz: Quiz!
    private var controllers: [UIViewController] = []
    private var questionIndex = 0
    
    private var quizIndexLabel: PopQuizLabel!
    
    init(quiz: Quiz) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
        for question in quiz.questions {
            let questionVC = QuestionViewController(question: question)
            questionVC.pageVC = self
            controllers.append(questionVC)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorBackground()
        
        
        guard let firstQuestionVC = controllers.first else { return }
        let pageAppearance = UIPageControl.appearance()
        pageAppearance.isHidden = true
        
        setViewControllers([firstQuestionVC], direction: .forward, animated: true, completion: nil)
    }
}

private extension QuizViewController {
    
    func initializeUIComponents() {
        quizIndexLabel = PopQuizLabel(text: "Placeholder", font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
    }
    
    func addSubviews() {
        
    }
    
    func setUpLayout() {
        
    }
    
}

extension QuizViewController {
    
    func showNextQuestion() {
        questionIndex += 1
        if questionIndex < controllers.count {
            setViewControllers([controllers[questionIndex]], direction: .forward, animated: true, completion: nil)
        }
        else {
            coordinator?.handleQuizFinished()
        }
    }
    
}
