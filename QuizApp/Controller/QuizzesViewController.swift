//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    PROPERTIES RELATED TO THE APP HEADER - THE APP TITLE AND THE GET QUIZZES BUTTON
    private let appTitle: AppLabel = AppLabel(frame: CGRect(), text: Utils.defaultStrings.appTitle, font: UIFont.AppTheme.title)
    private let getQuizzesButton: AppButton = AppButton(frame: CGRect(), font: UIFont.AppTheme.bodyBold, title: Utils.defaultStrings.getQuizString)
    
//    PROPERTIES RELATED TO THE INITIAL ERROR MESSAGE WHICH IS SHOWN WHEN QUIZZES HAVEN'T BEEN/CAN'T BE LOADED
    private let errorSymbol: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: Utils.symbols.noQuizzesSymbol))
        imageView.sizeToFit()
        imageView.tintColor = UIColor.AppTheme.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let errorLabel: AppLabel = AppLabel(frame: CGRect(), text: "Error", font: UIFont.AppTheme.heading2)
    private let errorDescription: AppLabel = AppLabel(frame: CGRect(), text: Utils.defaultStrings.noQuizzesDescription, font: UIFont.AppTheme.bodyLight)
    private let errorContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    TABLEVIEW RELATED PROPERTIES
    private let cellIdentifier = "cellId"
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .init(white: 1, alpha: 0)
        tableView.isHidden = true
        return tableView
    }()
    
//    MODEL PROPERTIES
    private let dataService: DataServiceProtocol = DataService()
    private var quizzes: [Quiz] = []
    private var quizzesByCategory = [QuizCategory : [Quiz]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
    
        colorBackground()
        addSubviews()
        setUpTableView()
        setUpLayout()
        setUpActions()
    }
}

extension QuizzesViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataService.getNoOfQuizCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let quizCategory : QuizCategory = QuizCategory.allCases[section]
        return quizzesByCategory[quizCategory]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UILabel()
        let label = UILabel(frame: CGRect())
        let quizCategory : QuizCategory = QuizCategory.allCases[section]
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = quizCategory.rawValue
        label.font = UIFont.AppTheme.heading3
        label.textAlignment = .left
        label.textColor = UIColor.AppTheme.white
        
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30),
                                     label.heightAnchor.constraint(equalTo: container.heightAnchor),
                                     label.rightAnchor.constraint(equalTo: container.rightAnchor)])
        
        return container
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AppTableViewCell
        let quizCategory : QuizCategory = QuizCategory.allCases[indexPath.section]
        let quiz = quizzesByCategory[quizCategory]![indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.setTitleLabel(title: quiz.title)
        cell.setDescriptionLabel(description: quiz.description)
        return cell
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AppTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
        setUpHeaderLayout()
        setUpErrorContainerLayout()
    }
    
    private func setUpHeaderLayout() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.topAnchor),
                                     appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
                                     appTitle.widthAnchor.constraint(greaterThanOrEqualToConstant: 140)])
        
        NSLayoutConstraint.activate([getQuizzesButton.topAnchor.constraint(equalTo: appTitle.bottomAnchor),
                                     getQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     getQuizzesButton.heightAnchor.constraint(equalToConstant: 45),
                                     getQuizzesButton.widthAnchor.constraint(equalToConstant: 300)])
    }
    
    private func setUpErrorContainerLayout() {
        NSLayoutConstraint.activate([errorContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     errorContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     errorContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8)])
        
        NSLayoutConstraint.activate([errorLabel.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
                                     errorLabel.centerYAnchor.constraint(equalTo: errorContainer.centerYAnchor)])
        
        NSLayoutConstraint.activate([errorSymbol.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
                                     errorSymbol.bottomAnchor.constraint(equalTo: errorLabel.topAnchor),
                                     errorSymbol.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
                                     errorSymbol.widthAnchor.constraint(equalTo: errorSymbol.heightAnchor)])
        
        NSLayoutConstraint.activate([errorDescription.centerXAnchor.constraint(equalTo: errorContainer.centerXAnchor),
                                     errorDescription.topAnchor.constraint(equalTo: errorLabel.bottomAnchor)])
    }
    
    private func setUpTableViewLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 20),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor)])
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
            categoriseQuizzes()
            showQuizzes()
        }
    }
    
    private func categoriseQuizzes() {
        quizzesByCategory = Dictionary(grouping: quizzes, by: {$0.category})
    }
    
    private func showQuizzes() {
        errorContainer.isHidden = true
        tableView.isHidden = false
        view.addSubview(tableView)
        setUpTableViewLayout()
    }
}
