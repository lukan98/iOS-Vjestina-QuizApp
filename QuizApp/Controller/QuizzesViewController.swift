//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController {
    
//    PROPERTIES RELATED TO THE APP HEADER - THE APP TITLE AND THE GET QUIZZES BUTTON
    private let appTitle: AppLabel = AppLabel(frame: CGRect(), text: Utils.appTitle, font: UIFont.AppTheme.title)
    private let getQuizzesButton: AppButton = AppButton(frame: CGRect(), font: UIFont.AppTheme.bodyBold, title: Utils.getQuizString)
    
//    PROPERTIES RELATED TO THE INITIAL ERROR MESSAGE WHICH IS SHOWN WHEN QUIZZES HAVEN'T BEEN/CAN'T BE LOADED
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
    
//    TABLEVIEW RELATED PROPERTIES
    let cellIdentifier = "cellId"
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
    
//    MODEL PROPERTIES
    private let dataService: DataServiceProtocol = DataService()
    private var quizzes: [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        view = UIView(frame: CGRect(x: 0, y: 0, width: viewSize, height: viewSize))
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        colorBackground()
        addSubviews()
        setUpLayout()
        setUpActions()
    }
}

extension QuizzesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataService.getNoOfQuizCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Label"
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let quizName = quizzes[indexPath.row].title
        cell.textLabel?.text = quizName
        
        cell.textLabel?.text = "\(quizName) Section: \(indexPath.section) Row: \(indexPath.row)"
        
        return cell
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
        NSLayoutConstraint.activate([tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 20),
                                     tableView.widthAnchor.constraint(equalTo: view.widthAnchor)])
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
            tableView.isHidden = false
            view.addSubview(tableView)
            setUpTableViewLayout()
        }
    }
}
