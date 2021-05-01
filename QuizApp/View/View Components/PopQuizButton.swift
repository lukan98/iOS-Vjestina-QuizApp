//
//  AppButton.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class PopQuizButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.PopQuizTheme.white
        self.layer.cornerRadius = Utils.cornerRadiuses.softCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(font: UIFont, title: String) {
        self.init(frame: CGRect())
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : UIColor.PopQuizTheme.purpleText])
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
