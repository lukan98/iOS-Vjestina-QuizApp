//
//  TextField.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class PopQuizTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.PopQuizTheme.whiteWithTransparency
        self.textColor = UIColor.PopQuizTheme.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.layer.cornerRadius = Utils.cornerRadiuses.softCornerRadius
    }
    
    convenience init(font: UIFont, placeholderText: String, isSecure: Bool) {
        self.init(frame: CGRect())
        self.font = font
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.PopQuizTheme.white])
        self.isSecureTextEntry = isSecure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Utils.defaultInset)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Utils.defaultInset)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Utils.defaultInset)
    }
    
    // TODO [Add border change on touch]
}

extension PopQuizTextField {
    
    @objc
    func setBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.PopQuizTheme.white.cgColor
    }
    
    @objc
    func hideBorder() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
