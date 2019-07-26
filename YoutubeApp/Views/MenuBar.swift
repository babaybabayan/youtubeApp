//
//  MenuBar.swift
//  YoutubeApp
//
//  Created by Fivecode on 27/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.backgroundColor = UIColor.rgb(r: 230, g: 32, b: 31)
        return collectionview
    }()
    
    let cellId = "menuBarCellId"
    let imageArrName = ["ic_home","ic_trending","ic_subscribe","ic_profile"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(menuBarCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintWithFormat(format: "V:|[v0]|", views: collectionView)
        
        let selectedIndex = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndex as IndexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArrName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! menuBarCell
        
        cell.imageView.image = UIImage(named: imageArrName[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(r: 91, g: 14, b: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class menuBarCell: BaseCell {
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(r: 91, g: 14, b: 13)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(r: 91, g: 14, b: 13)
        }
    }
    
    override var isSelected: Bool{
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor.rgb(r: 91, g: 14, b: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
