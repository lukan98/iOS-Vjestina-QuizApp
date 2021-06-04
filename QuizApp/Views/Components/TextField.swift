//
//  TextField.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.PopQuizPalette.whiteLessOpaque
        self.textColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.layer.cornerRadius = Utils.DefaultCornerRadiuses.softCornerRadius
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    convenience init(font: UIFont, placeholderText: String, isSecure: Bool) {
        self.init(frame: CGRect())
        self.font = font
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
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
}

extension TextField {
    
    @objc
    func setBorder() {
        self.layer.borderWidth = 1
    }
    
    @objc
    func hideBorder() {
        self.layer.borderWidth = 0
    }
}
