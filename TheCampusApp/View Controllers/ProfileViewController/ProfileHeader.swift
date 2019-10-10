//
//  Header.swift
//  TheCampusApp
//
//  Created by Yogesh Kumar on 27/09/19.
//  Copyright © 2019 Harsh Motwani. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionViewCell{
    // Constants
    var height: CGFloat = 0
    
    // UI Elements
    let profilePic: RoundImageView = {
        let imageView = RoundImageView()
        imageView.image = UIImage(named: "Avatar")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserData.shared.name ?? "Yogesh Kumar"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .cyan
        return label
    }()
    
    let followingStatLabel: UILabel = {
        let label = UILabel()
        let count = UserData.shared.followingCount ?? 0
        let attributedText = NSMutableAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\nFollowing", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    let followersStatLabel: UILabel = {
        let label = UILabel()
        let count = UserData.shared.followerCount ?? 0
        let attributedText = NSMutableAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\nFollowers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    let likesStatLabel: UILabel = {
        let label = UILabel()
        let count = UserData.shared.likesCount ?? 0
        let attributedText = NSMutableAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\nLikes", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    let questionsStatLabel: UILabel = {
        let label = UILabel()
        let count = UserData.shared.questionsCount ?? 0
        let attributedText = NSMutableAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\nQuestions", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    let answersStatLabel: UILabel = {
        let label = UILabel()
        let count = UserData.shared.answersCount ?? 0 
        let attributedText = NSMutableAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\nAnswers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    // TODO: Add Some stat here and then also update it in statStack2 in setupStack method
    let somethingStatLabel: UILabel = {
        let label = UILabel()
        let count = UserData.shared.likesCount ?? 0
        let attributedText = NSMutableAttributedString(string: "\(count)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "\nSomething", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    var statStack1: UIStackView!
    var statStack2: UIStackView!
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
//        button.backgroundColor = .gray
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
//        backgroundColor = .yellow
        setupProfilePic()
        setupNameLabel()
        setupStats()
        setupEditProfileButton()
        addSeperator()
    }
    
    func setupProfilePic(){
        let imagePadding = frame.height * 0.08
        addSubview(profilePic)
        profilePic.anchor(top: topAnchor, left: leadingAnchor, paddingTop: imagePadding, paddingLeft: imagePadding)
        profilePic.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60).isActive = true
        profilePic.widthAnchor.constraint(equalTo: profilePic.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setupNameLabel(){
        addSubview(nameLabel)
        nameLabel.centerX(profilePic.centerXAnchor)
        nameLabel.anchor(top: profilePic.bottomAnchor, bottom: bottomAnchor)
    }
    
    func setupStats(){
        let padding: CGFloat = 10
        
        // StatStack1
        statStack1 = UIStackView(arrangedSubviews: [followingStatLabel, followersStatLabel, likesStatLabel])
        statStack1.axis = .horizontal
        statStack1.distribution = .fillEqually
        addSubview(statStack1)
        statStack1.anchor(top: profilePic.topAnchor, left: profilePic.trailingAnchor, right: trailingAnchor, paddingTop: padding, paddingRight: 5)
        
        // StatStack2
        statStack2 = UIStackView(arrangedSubviews: [questionsStatLabel, answersStatLabel, somethingStatLabel])
        statStack2.axis = .horizontal
        statStack2.distribution = .fillEqually
        addSubview(statStack2)
        statStack2.anchor(bottom: profilePic.bottomAnchor, left: profilePic.trailingAnchor, right: trailingAnchor, paddingBottom: padding, paddingRight: 5)
    }
    
    func setupEditProfileButton(){
        addSubview(editProfileButton)
        editProfileButton.centerY(nameLabel.centerYAnchor)
        editProfileButton.anchor(left: nameLabel.trailingAnchor, right: trailingAnchor, paddingLeft: 20, paddingRight: 20)
    }
    
    func addSeperator(){
        let line = UIView()
        line.backgroundColor = .black
        addSubview(line)
        line.anchor(bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor, paddingBottom: 0, height: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RoundImageView: UIImageView{
    
    init(){
        super.init(frame: .zero)
        self.clipsToBounds = true
    }
    
    override var bounds: CGRect {
        didSet {
            layer.cornerRadius = bounds.height/2
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
