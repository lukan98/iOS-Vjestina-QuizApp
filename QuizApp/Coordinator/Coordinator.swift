//
//  Coordinator.swift
//  QuizApp
//
//  Created by Luka Namačinski on 02.05.2021..
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccured(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
