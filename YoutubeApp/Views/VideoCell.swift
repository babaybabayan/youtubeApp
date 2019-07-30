//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by Fivecode on 27/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var titleLabelConstraint: NSLayoutConstraint?
    
    var videoc: Video? {
        didSet {
            titleLabel.text = videoc?.title
            
            setupThumbnailUrl()
            setupProfileImageUrl()
//            if let thumbImage = videoc?.thumbnailImageName {
//                thumbnailImageView.image = UIImage(named: thumbImage)
//            }
            
//            if let profileImage = videoc?.channel?.profilImage {
//                userProfileImage.image = UIImage(named: profileImage)
//            }
            
            if let channelName = videoc?.channel?.profile, let numberViews = videoc?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitle = "\(channelName) - \(numberFormatter.string(from: numberViews)!) - 2 years ago"
                subtitleTextview.text = subtitle
            }
            
            if let title = videoc?.title {
                let size = CGSize(width: frame.height - 16 - 44 - 8 - 16, height: 1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                //print(estimatedRect.size)
                if estimatedRect.size.height > 20 {
                    titleLabelConstraint?.constant = 44
                } else {
                    titleLabelConstraint?.constant = 20
                }
            }
        }
    }
    
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
        label.numberOfLines = 2
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
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImage, seperatorView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: seperatorView)
        // Title Label Constraint Layout
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        titleLabelConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelConstraint!)
        
        // Subtitle Label Constraint Layout
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subtitleTextview, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
    func setupThumbnailUrl() {
        if let thumnailImageurl = videoc?.thumbnailImageName {
            thumbnailImageView.usingImageWithUrl(imageUrl: thumnailImageurl)
        }
    }
    
    func setupProfileImageUrl() {
        if let profileImage = videoc?.channel?.profilImage {
            userProfileImage.usingImageWithUrl(imageUrl: profileImage)
        }
    }
}
