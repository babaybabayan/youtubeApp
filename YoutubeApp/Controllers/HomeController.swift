//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Fivecode on 30/06/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let urlJson = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    
//    let videos: [Video] = {
//        let babayChannel = Channel()
//        let abayChannel = Channel()
//        babayChannel.profile = "Akbar Putera W"
//        babayChannel.profilImage = "arielprofileimage"
//        abayChannel.profile = "Babay"
//        abayChannel.profilImage = "ironman"
//
//        let video = Video()
//        video.channel = babayChannel
//        video.title = "Guns n Roses - Sweet Child O'Mine"
//        video.thumbnailImageName = "lunamaya"
//        video.numberOfViews = 12349949
//
//        let video2 = Video()
//        video2.channel = abayChannel
//        video2.title = "Guns n Roses - Be Patient"
//        video2.thumbnailImageName = "arielprofileimage"
//        video2.numberOfViews = 12333223
//        return [video, video2]
//    }()
    
    var videos: [Video]?
    
    lazy var navigationTitle: UILabel = {
        let titleView = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleView.text = "Home"
        titleView.font = UIFont.systemFont(ofSize: 20)
        titleView.textColor = UIColor.white
        return titleView
    }()
    
    let menubar: MenuBar = {
        let menu = MenuBar()
        
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = navigationTitle
        
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtom()
        
        fetchRequest()
    }
    
    func setupNavBarButtom() {
        let searchImage = UIImage(named: "ic_search")?.withRenderingMode(.alwaysTemplate)
        let optionImage = UIImage(named: "ic_option")?.withRenderingMode(.alwaysTemplate)
        let searchBarItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let optionBarItem = UIBarButtonItem(image: optionImage, style: .plain, target: self, action: #selector(handleOption))
        navigationItem.rightBarButtonItems = [optionBarItem, searchBarItem]
    }
    
    @objc func handleSearch() {
        print("Search Pressed")
    }
    
    @objc func handleOption() {
        print("Option Pressed")
    }
    
    func fetchRequest(){
        let request = URLRequest(url: urlJson! as URL)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            self.videos = [Video]()
            for theData in json as! [[String : AnyObject]] {
                let video = Video()
                let channel = Channel()
                
                video.title = theData["title"] as? String
                video.thumbnailImageName = theData["thumbnail_image_name"] as? String
                video.numberOfViews = theData["number_of_views"] as? NSNumber
                channel.profile = theData["channel"]!["name"] as? String
                channel.profilImage = theData["channel"]!["profile_image_name"] as? String
                video.channel = channel
                
                self.videos?.append(video)
            }
            
            DispatchQueue.main.async(execute: {
                self.collectionView.reloadData()
            })
            
        }.resume()
    }
    
    func setupMenuBar() {
        view.addSubview(menubar)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menubar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]", views: menubar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? VideoCell
        
        cell?.videoc = videos?[indexPath.row]
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
}
