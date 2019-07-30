//
//  Extensions.swift
//  YoutubeApp
//
//  Created by Fivecode on 27/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintWithFormat(format: String, views: UIView...){
        var viewDictonary = [String:UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictonary[key] = view
        }
        
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictonary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func usingImageWithUrl(imageUrl: String) {
        
        let request = URLRequest(url: NSURL(string: imageUrl)! as URL)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) {
            self.image = imageFromCache as? UIImage
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: imageUrl as AnyObject)
                self.image = imageToCache
            })
        }.resume()
    }
}
