//
//  AppTableViewCell.swift
//  QuizApp
//
//  Created by Luka Namačinski on 12.04.2021..
//

import UIKit

class AppTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppTheme.whiteWithTransparency
        view.layer.cornerRadius = Utils.cornerRadiuses.sharpCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.AppTheme.white.cgColor
        return view
    }()
    
    private let titleLabel: AppLabel = {
        let title = AppLabel(frame: CGRect())
        title.font = UIFont.AppTheme.bodyBold
        title.textAlignment = .left
        return title
    }()
    
    private let descriptionLabel: AppLabel = {
        let description = AppLabel(frame: CGRect())
        description.font = UIFont.AppTheme.bodyRegular
        description.textAlignment = .left
        description.sizeToFit()
        return description
    }()
    
    private let picture: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "questionmark.circle.fill"))
        imageView.sizeToFit()
        imageView.tintColor = UIColor.AppTheme.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var rating: Int
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.rating = 0
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addSubviews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(picture)
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
    }
    
    func setTitleLabel(title: String) {
        titleLabel.text = title
    }
    
    func setDescriptionLabel(description: String) {
        descriptionLabel.text = description
    }
    
    func setRating(rating: Int) {
        self.rating = rating
    }
}
