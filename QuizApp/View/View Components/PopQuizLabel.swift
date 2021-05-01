//
//  AppLabel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class PopQuizLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
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
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
