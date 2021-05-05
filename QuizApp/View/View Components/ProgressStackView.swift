//
//  ProgressStackView.swift
//  QuizApp
//
//  Created by Luka Namačinski on 06.05.2021..
//

import UIKit

class ProgressStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: CGRect())
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .equalSpacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(noOfSegments: Int) {
        self.init()
        for _ in 0..<noOfSegments {
            let rect = UIView(frame: CGRect())
            rect.translatesAutoresizingMaskIntoConstraints = false
            rect.layer.cornerRadius = 2
            rect.backgroundColor = UIColor.PopQuizTheme.whiteWithTransparency
            addArrangedSubview(rect)
        }
    }
    
    func colorSubview(at index: Int, color: UIColor, animationDuration duration: Double = 0) {
        UIView.animate(withDuration: duration, animations: {
            self.arrangedSubviews[index].backgroundColor = color
        }, completion: nil)
    }
    
}
