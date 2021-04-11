//
//  AppErrorLabel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.04.2021..
//

import UIKit

class AppErrorLabel: UILabel {
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.AppTheme.alert
        self.backgroundColor = UIColor.AppTheme.red
        self.layer.cornerRadius = Utils.defaultCornerRadius
        self.layer.masksToBounds = true
        self.textColor = UIColor.AppTheme.white
        self.textAlignment = .center
    }
    
    convenience init(frame: CGRect, text: String) {
        self.init(frame: frame)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}