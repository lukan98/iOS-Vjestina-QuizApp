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
        self.layer.cornerRadius = Utils.defaultCornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.AppTheme.bold, NSAttributedString.Key.foregroundColor : UIColor.AppTheme.purpleLight])
        self.setAttributedTitle(attributedTitle, for: .normal)
        self.setTitle(Utils.signInString, for: .normal)
        self.setTitleColor(UIColor.AppTheme.purpleLight, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
