//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController {
    
    private let appTitle: AppLabel = AppLabel(frame: CGRect(), text: Utils.appTitle, font: UIFont.AppTheme.title)
    private let getQuizzesButton: AppButton = AppButton(frame: CGRect(), font: UIFont.AppTheme.bodyBold, title: Utils.getQuizString)
    private let errorSymbol: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: Utils.noQuizzesSymbol))
        imageView.sizeToFit()
        imageView.tintColor = UIColor.AppTheme.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let errorLabel: AppLabel = AppLabel(frame: CGRect(), text: "Error", font: UIFont.AppTheme.heading2)
    private let errorDescription: AppLabel = AppLabel(frame: CGRect(), text: Utils.noQuizzesDescription, font: UIFont.AppTheme.bodyLight)
    private let errorContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dataService: DataServiceProtocol = DataService()
    private var quizzes: [Quiz]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
        colorBackground()
        addSubviews()
        setUpLayout()
        setUpActions()
    }
    
}

private extension QuizzesViewController {
    
    private func addSubviews() {
        errorContainer.addSubview(errorLabel)
        errorContainer.addSubview(errorDescription)
        errorContainer.addSubview(errorSymbol)
        view.addSubview(appTitle)
        view.addSubview(getQuizzesButton)
        view.addSubview(errorContainer)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                                     appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTitle.heightAnchor.constraint(equalToConstant: 50),
                                     appTitle.widthAnchor.constraint(greaterThanOrEqualToConstant: 140)])
        
        NSLayoutConstraint.activate([getQuizzesButton.topAnchor.constraint(greaterThanOrEqualTo: appTitle.bottomAnchor, constant: 30),
                                     getQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     getQuizzesButton.heightAnchor.constraint(equalToConstant: 45),
                                     getQuizzesButton.widthAnchor.constraint(equalToConstant: 300)])
        
        NSLayoutConstraint.activate([errorContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     errorContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
                                     errorContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     errorContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)])
        
        NSLayoutConstraint.activate([errorLabel.centerXAnchor.constraint(lessThanOrEqualTo: errorContainer.centerXAnchor),
                                     errorLabel.centerYAnchor.constraint(equalTo: errorContainer.centerYAnchor)])
        
        NSLayoutConstraint.activate([errorSymbol.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
                                     errorSymbol.centerYAnchor.constraint(lessThanOrEqualTo: errorContainer.centerYAnchor, constant: -80),
                                     errorSymbol.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
                                     errorSymbol.widthAnchor.constraint(equalTo: errorSymbol.heightAnchor)])
        
        NSLayoutConstraint.activate([errorDescription.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
                                     errorDescription.centerYAnchor.constraint(lessThanOrEqualTo: errorLabel.bottomAnchor, constant: 20)])
    }
}

private extension QuizzesViewController {
    
    private func setUpActions() {
        getQuizzesButton.addTarget(self, action: #selector(fetchQuizzes), for: .touchUpInside)
    }
    
    @objc
    private func fetchQuizzes() {
        quizzes = dataService.fetchQuizes()
        if (quizzes.count != 0) {
            print("Quizzes fetched!")
            errorContainer.isHidden = true
        }
    }
}
