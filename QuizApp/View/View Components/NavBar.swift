//
//  PopQuizNavBar.swift
//  QuizApp
//
//  Created by Luka Namačinski on 04.05.2021..
//

import UIKit

class NavBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTransparency()
        customizeColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    private func setTransparency() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
    
    private func customizeColors() {
        barStyle = .black
        tintColor = UIColor.PopQuizTheme.white
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.PopQuizTheme.white,
                               NSAttributedString.Key.font: UIFont.PopQuizTheme.heading2]
    }
}
