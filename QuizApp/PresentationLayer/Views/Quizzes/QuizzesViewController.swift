//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController, QuizzesDelegate {
    var presenter: QuizzesPresenterProtocol!

    var appTitle: Label!

    var errorSymbol: UIImageView!
    var errorLabel: Label!
    var errorDescription: Label!
    var errorContainer: UIView!

    var funFactContainer: UIView!
    var funFactTitle: Label!
    var funFactDescription: Label!

    var tableView: UITableView!
    
    override func viewDidLoad() {
        buildViews()
        presenter.fetchQuizzes(filter: nil)
    }
    
    func showQuizzes() {
        funFactContainer.isHidden = false
        errorContainer.isHidden = true
        tableView.isHidden = false
    }
    
    func showError() {
        funFactContainer.isHidden = true
        tableView.isHidden = true
        errorContainer.isHidden = false
    }
    
    func setErrorMessage(message: String) {
        errorDescription.text = message
    }
    
    func setFunFact(funFact: String) {
        funFactDescription.text = funFact
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}

extension QuizzesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getNoOfQuizCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getQuizCountForCategory(categoryIndex: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()
        let quizCategory = presenter.getQuizCategoryForSection(section: section)
        let label = Label(text: quizCategory,
                          font: .PopQuizDefaultFonts.heading3,
                          textAlignment: .left)
        container.addSubview(label)
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30),
                                     label.heightAnchor.constraint(equalTo: container.heightAnchor),
                                     label.rightAnchor.constraint(equalTo: container.rightAnchor)])
        return container
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizCell.cellID, for: indexPath) as? QuizCell,
              let quiz = presenter.getQuiz(at: indexPath)
        else {
            return QuizCell()
        }
        
        cell.backgroundColor = UIColor.clear
        cell.setTitleLabel(title: quiz.title)
        cell.setDescriptionLabel(description: quiz.description)
        cell.setLevel(level: quiz.level)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleQuizSelection(at: indexPath)
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuizCell.self, forCellReuseIdentifier: QuizCell.cellID)
    }
}
