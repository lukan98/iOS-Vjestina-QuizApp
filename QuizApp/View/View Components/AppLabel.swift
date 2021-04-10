//
//  AppLabel.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class AppLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.AppTheme.title
        self.backgroundColor = UIColor(white: 1, alpha: 0)
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
