//
//  SettingsDelegate.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.05.2021..
//

import Foundation

protocol SettingsDelegate: Delegate {
    var presenter: SettingsPresenterProtocol! { get set }
}
