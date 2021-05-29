//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController, QuizzesDelegate {
    var presenter: QuizzesPresenterProtocol!

    private var appTitle: Label!
    private var getQuizzesButton: Button!

    private var errorSymbol: UIImageView!
    private var errorLabel: Label!
    private var errorDescription: Label!
    private var errorContainer: UIView!
    
    //TODO: Add loading wheel

    private var funFactContainer: UIView!
    private var funFactTitle: Label!
    private var funFactDescription: Label!

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        colorBackground()
        initalizeUIComponents()
        addSubviews()
        setUpTableView()
        setUpLayout()
        setUpActions()
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
        let label = Label(text: quizCategory.rawValue,
                          font: .PopQuizDefaultFonts.heading3,
                          textAlignment: .left)
        container.addSubview(label)
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30),
                                     label.heightAnchor.constraint(equalTo: container.heightAnchor),
                                     label.rightAnchor.constraint(equalTo: container.rightAnchor)])
        return container
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizCell.cellID, for: indexPath) as! QuizCell
        let quiz = presenter.getQuiz(at: indexPath)
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

private extension QuizzesViewController {
    
    func initalizeUIComponents() {
        appTitle = Label(text: .DefaultStrings.appTitle,
                         font: UIFont.PopQuizDefaultFonts.heading2,
                         textAlignment: .center)
        getQuizzesButton = Button(font: UIFont.PopQuizDefaultFonts.bodyBold,
                                  title: .DefaultStrings.getQuizString)
        
        errorSymbol = {
            let imageView = UIImageView(image: UIImage(named: .SymbolStrings.quizzesError))
            imageView.sizeToFit()
            imageView.tintColor = UIColor.white
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        errorLabel = Label(text: "Error", font: UIFont.PopQuizDefaultFonts.heading2)
        errorDescription = Label(text: .DefaultStrings.noQuizzesDescription,
                                 font: UIFont.PopQuizDefaultFonts.bodyLight)
        errorDescription.numberOfLines = 0
        errorContainer = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        funFactContainer = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true
            return view
        }()
        funFactTitle = Label(text: .DefaultStrings.funFact,
                             font: UIFont.PopQuizDefaultFonts.bodyBold,
                             textAlignment: .left)
        funFactDescription = Label(text: "",
                                   font: UIFont.PopQuizDefaultFonts.bodyLight,
                                   textAlignment: .left)

        tableView = {
            let tableView = UITableView(frame: CGRect(), style: .grouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .init(white: 1, alpha: 0)
            return tableView
        }()
    }
}

private extension QuizzesViewController {
    
    func addSubviews() {
        funFactContainer.addSubview(funFactTitle)
        funFactContainer.addSubview(funFactDescription)
        
        errorContainer.addSubview(errorLabel)
        errorContainer.addSubview(errorDescription)
        errorContainer.addSubview(errorSymbol)
        
        view.addSubview(appTitle)
        view.addSubview(getQuizzesButton)
        view.addSubview(errorContainer)
        view.addSubview(funFactContainer)
        view.addSubview(tableView)
        
        tableView.isHidden = true
        errorContainer.isHidden = true
        funFactContainer.isHidden = true
    }
    
    func setUpLayout() {
        setUpHeaderLayout()
        setUpErrorContainerLayout()
        setUpFunFactLayout()
        setUpTableViewLayout()
    }
    
    func setUpHeaderLayout() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTitle.heightAnchor.constraint(equalToConstant: 45),
                                     appTitle.widthAnchor.constraint(equalToConstant: 300)])
        
        NSLayoutConstraint.activate([getQuizzesButton.topAnchor.constraint(equalTo: appTitle.bottomAnchor),
                                     getQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     getQuizzesButton.heightAnchor.constraint(equalToConstant: 45),
                                     getQuizzesButton.widthAnchor.constraint(equalToConstant: 300)])
    }
    
    func setUpFunFactLayout() {
        NSLayoutConstraint.activate([funFactTitle.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 5),
                                     funFactTitle.rightAnchor.constraint(equalTo: getQuizzesButton.rightAnchor),
                                     funFactTitle.widthAnchor.constraint(equalTo: getQuizzesButton.widthAnchor),
                                     funFactTitle.heightAnchor.constraint(equalToConstant: 25)])
        
        NSLayoutConstraint.activate([funFactDescription.topAnchor.constraint(equalTo: funFactTitle.bottomAnchor),
                                     funFactDescription.rightAnchor.constraint(equalTo: funFactTitle.rightAnchor),
                                     funFactDescription.widthAnchor.constraint(equalTo: funFactTitle.widthAnchor),
                                     funFactDescription.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    func setUpErrorContainerLayout() {
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
    
    func setUpTableViewLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: funFactDescription.bottomAnchor, constant: 5),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    func setUpActions() {
        getQuizzesButton.addTarget(self, action: #selector(fetchQuizzes), for: .touchUpInside)
    }
    
    @objc
    func fetchQuizzes() {
        presenter.fetchQuizzes()
    }
}
