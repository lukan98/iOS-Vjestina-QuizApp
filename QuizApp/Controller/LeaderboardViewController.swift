//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.05.2021..
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private var titleLabel: Label!
    private var exitButton: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leaderboard"
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
}

private extension LeaderboardViewController {
    
    func initializeUIComponents() {
        titleLabel = Label(text: "Leaderboard", font: .PopQuizDefaultFonts.heading2, textAlignment: .center)
        exitButton = UIImageView(image: UIImage(named: .SymbolStrings.exit))
        exitButton.tintColor = .white
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        exitButton.isUserInteractionEnabled = true
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(exitButton)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                                     titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 20),
                                     titleLabel.widthAnchor.constraint(equalToConstant: 150)])
        
        NSLayoutConstraint.activate([exitButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
                                     exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
                                     exitButton.widthAnchor.constraint(equalToConstant: 20),
                                     exitButton.heightAnchor.constraint(equalToConstant: 20)])
    }
}

private extension LeaderboardViewController {
    @objc
    func goBack() {
        dismiss(animated: true, completion: nil)
    }
}
