//
//  AppTableViewCell.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class PopQuizTableViewCell: UITableViewCell {
    
    private var containerView: UIView!
    private var titleLabel: PopQuizLabel!
    private var descriptionLabel: PopQuizLabel!
    private var picture: UIImageView!
    private var levelStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUIComponents() {
        containerView = {
            let view = UIView()
            view.backgroundColor = UIColor.PopQuizTheme.whiteWithTransparency
            view.layer.cornerRadius = Utils.cornerRadiuses.sharpCornerRadius
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        titleLabel = PopQuizLabel(text: "", font: UIFont.PopQuizTheme.bodyBold, textAlignment: .left)
        descriptionLabel = PopQuizLabel(text: "", font: UIFont.PopQuizTheme.bodyRegular, textAlignment: .left)
        descriptionLabel.sizeToFit()
        picture = {
            let imageView = UIImageView(image: UIImage(systemName: "questionmark.circle.fill"))
            imageView.sizeToFit()
            imageView.tintColor = UIColor.PopQuizTheme.white
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        levelStackView = {
            let view = UIStackView()
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.distribution = .equalSpacing
            for _ in 0..<3 {
                let levelView = UIImageView(image: UIImage(systemName: Utils.symbols.levelSymbol))
                levelView.contentMode = .scaleAspectFit
                view.addArrangedSubview(levelView)
            }
            return view
        }()
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(picture)
        containerView.addSubview(levelStackView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                                     containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
                                     containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                                     containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)])

        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                                     titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                                     titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.63),
                                     titleLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.33)])
        
        NSLayoutConstraint.activate([descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                                     descriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                                     descriptionLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor)])
        
        NSLayoutConstraint.activate([picture.topAnchor.constraint(equalTo: containerView.topAnchor),
                                     picture.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5),
                                     picture.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.33),
                                     picture.heightAnchor.constraint(equalTo: containerView.heightAnchor)])
        
        NSLayoutConstraint.activate([levelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
                                     levelStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15),
                                     levelStackView.widthAnchor.constraint(equalToConstant: 70),
                                     levelStackView.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func setDescriptionLabel(description: String) {
        descriptionLabel.text = description
    }
    
    func setLevel(level: Int) {
        for i in 1..<levelStackView.arrangedSubviews.count+1 {
            if (i<=level) {
                levelStackView.arrangedSubviews[i-1].tintColor = UIColor.PopQuizTheme.gold
            }
            else {
                levelStackView.arrangedSubviews[i-1].tintColor = UIColor.darkGray
            }
        }
    }
}
