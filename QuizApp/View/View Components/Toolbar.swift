//
//  Toolbar.swift
//  QuizApp
//
//  Created by Luka Namačinski on 06.05.2021..
//

import UIKit

class Toolbar: UIToolbar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        isTranslucent = false
        tintColor = UIColor.PopQuizTheme.purpleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
