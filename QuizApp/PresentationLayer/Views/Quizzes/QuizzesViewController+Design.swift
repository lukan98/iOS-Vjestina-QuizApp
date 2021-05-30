//
//  QuizzesViewController+Result.swift
//  QuizApp
//
//  Created by Luka Namačinski on 30.05.2021..
//

import Foundation
import UIKit

extension QuizzesViewController {
    
    func buildViews() {
        colorBackground()
        initalizeUIComponents()
        addSubviews()
        setUpTableView()
        setUpLayout()
    }
    
    private func addSubviews() {
        funFactContainer.addSubview(funFactTitle)
        funFactContainer.addSubview(funFactDescription)
        
        errorContainer.addSubview(errorLabel)
        errorContainer.addSubview(errorDescription)
        errorContainer.addSubview(errorSymbol)
        
        view.addSubview(appTitle)
        view.addSubview(errorContainer)
        view.addSubview(funFactContainer)
        view.addSubview(tableView)
        
        tableView.isHidden = true
        errorContainer.isHidden = true
        funFactContainer.isHidden = true
    }
    
    private func setUpLayout() {
        setUpHeaderLayout()
        setUpErrorContainerLayout()
        setUpFunFactLayout()
        setUpTableViewLayout()
    }
    
    private func setUpHeaderLayout() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     appTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTitle.heightAnchor.constraint(equalToConstant: 45),
                                     appTitle.widthAnchor.constraint(equalToConstant: 300)])
    }
    
    private func setUpFunFactLayout() {
        NSLayoutConstraint.activate([funFactTitle.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 5),
                                     funFactTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     funFactTitle.widthAnchor.constraint(equalToConstant: 300),
                                     funFactTitle.heightAnchor.constraint(equalToConstant: 25)])
        
        NSLayoutConstraint.activate([funFactDescription.topAnchor.constraint(equalTo: funFactTitle.bottomAnchor),
                                     funFactDescription.rightAnchor.constraint(equalTo: funFactTitle.rightAnchor),
                                     funFactDescription.widthAnchor.constraint(equalTo: funFactTitle.widthAnchor),
                                     funFactDescription.heightAnchor.constraint(equalToConstant: 40)])
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
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: funFactDescription.bottomAnchor, constant: 5),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.leftAnchor.constraint(equalTo: view.leftAnchor)])
    }
    
    private func initalizeUIComponents() {
        appTitle = Label(text: .DefaultStrings.appTitle,
                         font: UIFont.PopQuizDefaultFonts.heading2,
                         textAlignment: .center)
        
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

