//
//  Utils.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

extension UIColor {
    struct AppTheme {
        static let purpleLight = UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1.00)
        static let purpleDark = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        static let gold = UIColor(red: 0.95, green: 0.79, blue: 0.30, alpha: 1.00)
        static let white = UIColor.white
        static let whiteWithTransparency = UIColor.white.withAlphaComponent(0.30)
        static let red = UIColor(red: 0.99, green: 0.40, blue: 0.40, alpha: 1.00)
    }
}

extension UIFont {
    struct AppTheme {
        static let title = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.heavy)
        static let bold = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        static let light = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        static let alert = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
    }
}

extension UIView {
    func setGradientColor(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

struct Utils {
    static let emailPlaceholder = "Email"
    static let passwordPlaceholder = "Password"
    static let signInString = "Sign in"
    static let appTitle = "PopQuiz"
    static let signInFail = "Sign in error"
    static let defaultCornerRadius = 20.0 as CGFloat
    static let defaultInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}
