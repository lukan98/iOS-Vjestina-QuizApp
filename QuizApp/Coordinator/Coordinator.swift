//
//  Coordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 02.05.2021..
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
