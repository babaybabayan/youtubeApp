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
