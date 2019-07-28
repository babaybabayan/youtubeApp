//
//  Video.swift
//  YoutubeApp
//
//  Created by Fivecode on 28/07/19.
//  Copyright © 2019 Fivecode. All rights reserved.
//

import Foundation

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var profile: String?
    var profilImage: String?
}
