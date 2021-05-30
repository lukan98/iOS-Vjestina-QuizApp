//
//  SearchViewController+Design.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension SearchViewController {
    
    func buildViews() {
        colorBackground()
        initializeUIComponents()
        addSubviews()
        setUpLayout()
        setUpTableView()
        setUpActions()
    }
    
    private func initializeUIComponents() {
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
    
    private func addSubviews() {
        view.addSubview(searchBarView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    private func setUpLayout() {
        setUpHeaderLayout()
        setUpTableViewLayout()
    }
    
    private func setUpHeaderLayout() {
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
    
    private func setUpTableViewLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    private func setUpActions() {
        searchTextField.addTarget(searchTextField, action: #selector(searchTextField.setBorder), for: .editingDidBegin)
        searchTextField.addTarget(searchTextField, action: #selector(searchTextField.hideBorder), for: .editingDidEnd)
        
        searchButton.addTarget(self, action: #selector(searchQuizzes), for: .touchUpInside)
    }
    
    @objc
    private func searchQuizzes() {
        guard let searchText = searchTextField.text else { return }
        presenter.fetchQuizzes(filter: searchText)
    }
    
}

