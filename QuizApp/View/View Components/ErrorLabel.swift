//
//  AppErrorLabel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.04.2021..
//

import UIKit

class ErrorLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.PopQuizTheme.red
        self.layer.cornerRadius = Utils.cornerRadiuses.sharpCornerRadius
        self.layer.masksToBounds = true
        self.textColor = UIColor.PopQuizTheme.white
        self.textAlignment = .center
    }
    
    convenience init(font: UIFont, text: String) {
        self.init(frame: CGRect())
        self.text = text
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
