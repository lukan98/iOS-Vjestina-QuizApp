//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import UIKit

class SearchViewController: UIViewController {
    var presenter: SearchPresenterProtocol!
    
    private var searchBarView: UIView!
    private var searchTextField: TextField!
    private var searchButton: Button!
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
        setUpTableView()
        setUpActions()
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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

extension SearchViewController: SearchDelegate {
    
    func reloadTable() {
        tableView.reloadData()
    }
    
}

private extension SearchViewController {
    
    func initializeUIComponents() {
        searchBarView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        searchTextField = {
            let view = TextField(font: UIFont.PopQuizDefaultFonts.bodyLight, placeholderText: "Type here", isSecure: false)
            view.autocorrectionType = .no
            return view
        }()
        searchButton = {
            let view = Button(font: UIFont.PopQuizDefaultFonts.bodyBold, title: "Search", textColor: .white, backgroundColor: .clear)
            return view
        }()
        tableView = {
            let tableView = UITableView(frame: CGRect(), style: .grouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .init(white: 1, alpha: 0)
            return tableView
        }()
    }
    
    func addSubviews() {
        view.addSubview(searchBarView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func setUpLayout() {
        setUpHeaderLayout()
        setUpTableViewLayout()
    }
    
    func setUpHeaderLayout() {
        NSLayoutConstraint.activate([searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                     searchBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     searchBarView.heightAnchor.constraint(equalToConstant: 45),
                                     searchBarView.widthAnchor.constraint(equalToConstant: 300)])
        
        NSLayoutConstraint.activate([searchTextField.topAnchor.constraint(equalTo: searchBarView.topAnchor),
                                     searchTextField.leftAnchor.constraint(equalTo: searchBarView.leftAnchor),
                                     searchTextField.heightAnchor.constraint(equalTo: searchBarView.heightAnchor),
                                     searchTextField.widthAnchor.constraint(equalToConstant: 230)])
        
        NSLayoutConstraint.activate([searchButton.topAnchor.constraint(equalTo: searchBarView.topAnchor),
                                     searchButton.rightAnchor.constraint(equalTo: searchBarView.rightAnchor),
                                     searchButton.heightAnchor.constraint(equalTo: searchBarView.heightAnchor),
                                     searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor)])
    }
    
    func setUpTableViewLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    func setUpActions() {
        searchTextField.addTarget(searchTextField, action: #selector(searchTextField.setBorder), for: .editingDidBegin)
        searchTextField.addTarget(searchTextField, action: #selector(searchTextField.hideBorder), for: .editingDidEnd)
        
        searchButton.addTarget(self, action: #selector(searchQuizzes), for: .touchUpInside)
    }
    
    @objc
    func searchQuizzes() {
        guard let searchText = searchTextField.text else { return }
        presenter.fetchQuizzes(filter: searchText)
    }
    
}
