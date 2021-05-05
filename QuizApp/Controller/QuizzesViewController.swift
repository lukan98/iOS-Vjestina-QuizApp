//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class QuizzesViewController: UIViewController {
    weak var coordinator: QuizzesCoordinator?
    
//      PROPERTIES RELATED TO THE APP HEADER - THE APP TITLE AND THE GET QUIZZES BUTTON
    private var getQuizzesButton: Button!
    
//      PROPERTIES RELATED TO THE INITIAL ERROR MESSAGE WHICH IS SHOWN WHEN QUIZZES HAVEN'T BEEN/CAN'T BE LOADED
    private var errorSymbol: UIImageView!
    private var errorLabel: Label!
    private var errorDescription: Label!
    private var errorContainer: UIView!
    
//      PROPERTIES RELATED TO THE FUN FACT DISPLAYED ABOVE THE TABLEVIEW
    private var funFactContainer: UIView!
    private var funFactTitle: Label!
    private var funFactDescription: Label!
    private var funFactIcon: UIImageView!
    
//      TABLEVIEW RELATED PROPERTIES
    private var cellIdentifier: String!
    private var tableView: UITableView!
    
//      MODEL PROPERTIES
    private let dataService: DataServiceProtocol = DataService()
    private var quizzes: [Quiz] = []
    private var quizzesByCategory = [QuizCategory : [Quiz]]()
    
    override func viewDidLoad() {
        title = Utils.defaultStrings.appTitle
        colorBackground()
        initalizeUIComponents()
        addSubviews()
        setUpTableView()
        setUpLayout()
        setUpActions()
    }
}

//      IMPLEMENTATION OF TABLEVIEWDELEGATE AND TABLEVIEWDATASOURCE
extension QuizzesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataService.getNoOfQuizCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let quizCategory : QuizCategory = QuizCategory.allCases[section]
        return quizzesByCategory[quizCategory]!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UILabel()
        let label = UILabel(frame: CGRect())
        let quizCategory : QuizCategory = QuizCategory.allCases[section]
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = quizCategory.rawValue
        label.font = UIFont.PopQuizTheme.heading3
        label.textAlignment = .left
        label.textColor = UIColor.PopQuizTheme.white
        
        NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 30),
                                     label.heightAnchor.constraint(equalTo: container.heightAnchor),
                                     label.rightAnchor.constraint(equalTo: container.rightAnchor)])
        return container
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        let quizCategory : QuizCategory = QuizCategory.allCases[indexPath.section]
        let quiz = quizzesByCategory[quizCategory]![indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.setTitleLabel(title: quiz.title)
        cell.setDescriptionLabel(description: quiz.description)
        cell.setLevel(level: quiz.level)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quizCategory : QuizCategory = QuizCategory.allCases[indexPath.section]
        let quiz = quizzesByCategory[quizCategory]![indexPath.row]
        coordinator?.handleQuizSelection(quiz: quiz)
    }
    
    func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

//      INITIALISING THE UI COMPONENTS
private extension QuizzesViewController {
    
    func initalizeUIComponents() {
        //      PROPERTIES RELATED TO THE APP HEADER - THE APP TITLE AND THE GET QUIZZES BUTTON
        getQuizzesButton = Button(font: UIFont.PopQuizTheme.bodyBold, title: Utils.defaultStrings.getQuizString)
        
        //      PROPERTIES RELATED TO THE INITIAL ERROR MESSAGE WHICH IS SHOWN WHEN QUIZZES HAVEN'T BEEN/CAN'T BE LOADED
        errorSymbol = {
            let imageView = UIImageView(image: UIImage(systemName: Utils.symbols.noQuizzesSymbol))
            imageView.sizeToFit()
            imageView.tintColor = UIColor.PopQuizTheme.white
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        errorLabel = Label(text: "Error", font: UIFont.PopQuizTheme.heading2)
        errorDescription = Label(text: Utils.defaultStrings.noQuizzesDescription, font: UIFont.PopQuizTheme.bodyLight)
        errorContainer = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        //      PROPERTIES RELATED TO THE FUN FACT DISPLAYED ABOVE THE TABLEVIEW
        funFactContainer = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true
            return view
        }()
        funFactTitle = Label(text: "Fun Fact", font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
        funFactDescription = Label(text: "", font: UIFont.PopQuizTheme.bodyLight, textAlignment: .left)
        funFactIcon = {
            let imageView = UIImageView(image: UIImage(systemName: Utils.symbols.funFactSymbol))
            imageView.sizeToFit()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tintColor = UIColor.PopQuizTheme.gold
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        //      TABLEVIEW RELATED PROPERTIES
        cellIdentifier = "cellId"
        tableView = {
            let tableView = UITableView(frame: CGRect(), style: .grouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .init(white: 1, alpha: 0)
            return tableView
        }()
    }
}

//      SETTING UP THE LAYOUT OF THE PAGE
private extension QuizzesViewController {
    
    func addSubviews() {
        funFactContainer.addSubview(funFactTitle)
        funFactContainer.addSubview(funFactDescription)
        funFactContainer.addSubview(funFactIcon)
        
        errorContainer.addSubview(errorLabel)
        errorContainer.addSubview(errorDescription)
        errorContainer.addSubview(errorSymbol)
        
        view.addSubview(getQuizzesButton)
        view.addSubview(errorContainer)
        view.addSubview(funFactContainer)
    }
    
    func setUpLayout() {
        setUpHeaderLayout()
        setUpErrorContainerLayout()
        setUpFunFactLayout()
    }
    
    func setUpHeaderLayout() {
        NSLayoutConstraint.activate([getQuizzesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     getQuizzesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     getQuizzesButton.heightAnchor.constraint(equalToConstant: 45),
                                     getQuizzesButton.widthAnchor.constraint(equalToConstant: 300)])
    }
    
    func setUpFunFactLayout() {
        NSLayoutConstraint.activate([funFactTitle.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 5),
                                     funFactTitle.rightAnchor.constraint(equalTo: getQuizzesButton.rightAnchor),
                                     funFactTitle.widthAnchor.constraint(equalTo: getQuizzesButton.widthAnchor, multiplier: 0.8),
                                     funFactTitle.heightAnchor.constraint(equalToConstant: 25)])
        
        NSLayoutConstraint.activate([funFactDescription.topAnchor.constraint(equalTo: funFactTitle.bottomAnchor),
                                     funFactDescription.rightAnchor.constraint(equalTo: funFactTitle.rightAnchor),
                                     funFactDescription.widthAnchor.constraint(equalTo: funFactTitle.widthAnchor),
                                     funFactDescription.heightAnchor.constraint(equalToConstant: 40)])
        
        NSLayoutConstraint.activate([funFactIcon.topAnchor.constraint(equalTo: funFactTitle.topAnchor),
                                     funFactIcon.rightAnchor.constraint(equalTo: funFactTitle.leftAnchor, constant: -5),
                                     funFactIcon.widthAnchor.constraint(equalTo: getQuizzesButton.widthAnchor, multiplier: 0.15),
                                     funFactIcon.bottomAnchor.constraint(equalTo: funFactDescription.bottomAnchor)])
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
    
    func showQuizzes() {
        errorContainer.isHidden = true
        funFactContainer.isHidden = false
        view.addSubview(tableView)
        setUpTableViewLayout()
    }
}

//      QUIZ FETCHING UTILITIES
private extension QuizzesViewController {
    
    func setUpActions() {
        getQuizzesButton.addTarget(self, action: #selector(fetchQuizzes), for: .touchUpInside)
    }
    
    @objc
    func fetchQuizzes() {
        quizzes = dataService.fetchQuizes()
        if (quizzes.count != 0) {
            print("Quizzes fetched!")
            categoriseQuizzes()
            setFunFactDescription()
            showQuizzes()
        }
    }
    
    func calculateFunFactOccurence(funFactWord: String) -> (Int) {
        let funFactWord = dataService.getRandomFunFactWord()
        let counter = quizzes.flatMap({$0.questions}).map({$0.question}).filter({$0.contains(funFactWord)}).count
        return counter
    }
    
    func categoriseQuizzes() {
        quizzesByCategory = Dictionary(grouping: quizzes, by: {$0.category})
    }
    
    func setFunFactDescription() {
        let word = dataService.getRandomFunFactWord()
        let occurences = calculateFunFactOccurence(funFactWord: word)
        funFactDescription.text = "Did you know there are \(occurences) quizzes with the word \(word) in them?"
    }
}
