//
//  Utils.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

extension UIColor {
    struct PopQuizTheme {
        static let purpleLight = UIColor(red: 0.45, green: 0.31, blue: 0.64, alpha: 1.00)
        static let purpleDark = UIColor(red: 0.15, green: 0.18, blue: 0.46, alpha: 1.00)
        static let purpleText = UIColor(red: 0.39, green: 0.16, blue: 0.87, alpha: 1.00)
        static let gold = UIColor(red: 0.95, green: 0.79, blue: 0.30, alpha: 1.00)
        static let white = UIColor.white
        static let whiteWithTransparency = UIColor.white.withAlphaComponent(0.30)
        static let red = UIColor(red: 0.99, green: 0.40, blue: 0.40, alpha: 1.00)
        static let green = UIColor(red: 0.44, green: 0.81, blue: 0.59, alpha: 1.00)
    }
}

extension UIFont {
    struct PopQuizTheme {
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
    func applyGradient(colors: [UIColor], size: CGSize) -> Void {
        clipsToBounds = true
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame.size = size
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIViewController {
    func colorBackground(colors: [UIColor] = [UIColor.PopQuizTheme.purpleLight, UIColor.PopQuizTheme.purpleDark]) -> Void {
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        self.view.applyGradient(colors: colors, size: CGSize(width: viewSize, height: viewSize))
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
        static let levelSymbol = "rhombus.fill"
    }
    static let defaultInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}

enum Event {
    case LoginSuccess
}
