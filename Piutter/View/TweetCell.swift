//
//  TweetCell.swift
//  Piutter
//
//  Created by Breno Ramos on 20/12/21.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48/2
        iv.backgroundColor = .twitterBlue
        
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1 // infinite number of lines, if not specified, it shows a ... at the end of the string
        label.text = "Some text caption"
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Eddie Brock @venom"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: K.Feed.commentButtonImage), for: .normal)
        
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: K.Feed.retweetButtonImage), for: .normal)
        
        button.addTarget(self, action: #selector(retweetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: K.Feed.likeButtonImage), for: .normal)
        
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .darkGray
        button.setImage(UIImage(named: K.Feed.shareButtonImage), for: .normal)
        
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, likeButton, shareButton, retweetButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let tweet = tweet else {return}
        infoLabel.text = tweet.user.username
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: tweet.user.profileImageUrl, completed: nil)
        
       
    }
    
    // MARK: - Selectors
    
    @objc func commentButtonTapped() {
        print("DEBUG: COMMENT TAPPED...")
    }
    
    @objc func retweetButtonTapped() {
        print("DEBUG: RETWEET TAPPED...")
    }
    
    @objc func likeButtonTapped() {
        print("DEBUG: LIKE TAPPED...")
    }
    
    @objc func shareButtonTapped() {
        print("DEBUG: SHARE TAPPED...")
    }
}
