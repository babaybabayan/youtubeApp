//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by Fivecode on 27/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lunamaya")
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arielprofileimage")
        imageView.contentMode = ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Peter Pan - Menunggu Pagi"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextview: UITextView = {
        let textVIew = UITextView()
        textVIew.translatesAutoresizingMaskIntoConstraints = false
        textVIew.textColor = UIColor.lightGray
        textVIew.textContainerInset = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 0)
        textVIew.text = "Akbar - 1,660,000 views - 2 years ago"
        return textVIew
    }()
    
    override func setupViews(){
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImage)
        addSubview(titleLabel)
        addSubview(subtitleTextview)
        
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImage)
        //vertical constraints
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImage, seperatorView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: seperatorView)
        // Title Label Constraint Layout
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        // Subtitle Label Constraint Layout
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}
