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
        static let purpleText = UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 1.00)
        static let gold = UIColor(red: 0.95, green: 0.79, blue: 0.30, alpha: 1.00)
        static let white = UIColor.white
        static let whiteWithTransparency = UIColor.white.withAlphaComponent(0.30)
        static let red = UIColor(red: 0.99, green: 0.40, blue: 0.40, alpha: 1.00)
    }
}

extension UIFont {
    struct AppTheme {
        static let title = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.black)
        static let subtitle = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.heavy)
        static let heading1 = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.heavy)
        static let heading2 = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        static let heading3 = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        static let bodyRegular = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        static let bodyBold = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        static let bodyLight = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
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

extension UIViewController {
    func colorBackground() {
        self.view.setGradientColor(colorOne: UIColor.AppTheme.purpleLight, colorTwo: UIColor.AppTheme.purpleDark)
    }
}

struct Utils {
    struct defaultStrings {
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
        static let signInString = "Sign in"
        static let appTitle = "PopQuiz"
        static let signInFail = "Sign in error"
        static let getQuizString = "Get Quiz"
        static let noQuizzesDescription = "Data can't be reached.\nPlease try again."
    }
    struct cornerRadiuses {
        static let softCornerRadius = 20.0 as CGFloat
        static let sharpCornerRadius = 10.0 as CGFloat
    }
    struct symbols {
        static let noQuizzesSymbol = "xmark.circle"
        static let funFactSymbol = "lightbulb.fill"
    }
    static let defaultInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}
