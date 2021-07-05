//
//  AppLabel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    init(_ from: Label) {
        super.init(frame: CGRect())
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = from.backgroundColor
        self.textColor = from.textColor
        self.textAlignment = from.textAlignment
        self.font = from.font
        self.text = from.text
    }
    
    convenience init(text: String, font: UIFont) {
        self.init(frame: CGRect())
        self.text = text
        self.font = font
    }
    
    convenience init(text: String, font: UIFont, textAlignment: NSTextAlignment) {
        self.init(text: text, font: font)
        self.textAlignment = textAlignment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
