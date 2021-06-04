//
//  LeaderboardCell.swift
//  QuizApp
//
//  Created by Luka Namačinski on 11.05.2021..
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    private var rankLabel: Label!
    private var usernameLabel: Label!
    private var scoreLabel: Label!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeUIComponents()
        addSubviews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LeaderboardCell {
    
    func initializeUIComponents() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = .zero
        self.layoutMargins = .zero
        rankLabel = Label(text: "", font: .PopQuizDefaultFonts.bodyBold, textAlignment: .left)
        usernameLabel = Label(text: "", font: .PopQuizDefaultFonts.bodyBold, textAlignment: .left)
        scoreLabel = Label(text: "", font: .PopQuizDefaultFonts.bodyBold, textAlignment: .right)
    }
    
    func addSubviews() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(scoreLabel)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([rankLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                                     rankLabel.widthAnchor.constraint(equalToConstant: 40),
                                     rankLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        NSLayoutConstraint.activate([usernameLabel.leftAnchor.constraint(equalTo: rankLabel.rightAnchor, constant: 5),
                                     usernameLabel.rightAnchor.constraint(equalTo: scoreLabel.leftAnchor),
                                     usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        
        NSLayoutConstraint.activate([scoreLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
                                     scoreLabel.widthAnchor.constraint(equalToConstant: 100),
                                     scoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
}

extension LeaderboardCell {
    
    func setUsername(username: String) {
        self.usernameLabel.text = username
    }
    
    func setScore(score: Double) {
        self.scoreLabel.text = String(format: "%.2f", score)
    }
    
    func setRank(rank: Int) {
        self.rankLabel.text = String(rank)
    }
}
