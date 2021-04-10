//
//  TextField.swift
//  QuizApp
//
//  Created by Luka Namačinski on 10.04.2021..
//

import UIKit

class TextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.AppTheme.whiteWithTransparency
        self.textColor = UIColor.AppTheme.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.layer.cornerRadius = Utils.defaultCornerRadius
        self.clipsToBounds = true
    }
    
    convenience init(frame: CGRect, placeholderText: String, isSecure: Bool) {
        self.init(frame: frame)
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.AppTheme.white])
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