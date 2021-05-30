//
//  Utils.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import Foundation
import UIKit

extension UIColor {
    struct PopQuizPalette {
        static let purple = UIColor.init(named: "Purple")!
        static let purpleText = UIColor.init(named: "PurpleText")!
        static let green = UIColor.init(named: "Green")!
        static let navy = UIColor.init(named: "Navy")!
        static let red = UIColor.init(named: "Red")!
        static let yellow = UIColor.init(named: "Yellow")!
        static let whiteLessOpaque = UIColor.init(white: 1, alpha: 0.3)
        static let whiteMoreOpaque = UIColor.init(white: 1, alpha: 0.6)
    }
}

extension UIFont {
    struct PopQuizDefaultFonts {
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
    func colorBackground(colors: [UIColor] = [UIColor.PopQuizPalette.purple, UIColor.PopQuizPalette.navy]) -> Void {
        let viewSize = max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        self.view.applyGradient(colors: colors, size: CGSize(width: viewSize, height: viewSize))
    }
}

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}

extension UITabBarController {
    func styleTabBar() {
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.PopQuizPalette.purpleText
    }
}

struct Utils {
    struct DefaultCornerRadiuses {
        static let softCornerRadius = 20.0 as CGFloat
        static let sharpCornerRadius = 10.0 as CGFloat
    }
    static let defaultInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}

extension String {
    struct SymbolStrings {
        static let back = "Back"
        static let exit = "Exit"
        static let quizIcon = "QuizIcon"
        static let quizzesError = "QuizzesError"
        static let levelRhombus = "Rhombus"
        static let search = "SearchIcon"
        static let settings = "Settings"
    }
    struct DefaultStrings {
        static let funFact = "💡 Fun Fact"
        static let emailPlaceholder = "Email"
        static let passwordPlaceholder = "Password"
        static let signInString = "Sign in"
        static let appTitle = "PopQuiz"
        static let signInFail = "Sign in error"
        static let getQuizString = "Get Quiz"
        static let noQuizzesDescription = "Data can't be reached.\nPlease try again."
        static let modelName = "QuizDBModel"
    }
}
