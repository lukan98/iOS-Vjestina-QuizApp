//
//  AppButton.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class AppButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.AppTheme.white
        self.layer.cornerRadius = Utils.cornerRadiuses.softCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(frame: CGRect, font: UIFont, title: String) {
        self.init(frame: frame)
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : UIColor.AppTheme.purpleText])
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
