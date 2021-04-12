//
//  AppLabel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class AppLabel: UILabel {
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        self.textColor = UIColor.AppTheme.white
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    convenience init(frame: CGRect, text: String, font: UIFont) {
        self.init(frame: frame)
        self.text = text
        self.font = font
    }
    
    convenience init(frame: CGRect, text: String, font: UIFont, textAlignment: NSTextAlignment) {
        self.init(frame: frame, text: text, font: font)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
