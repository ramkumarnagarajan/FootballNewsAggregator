//
//  TweetUser.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/15/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import Foundation
class TweetUser
{
    let name:String?
    let twitterHandle:String?
    let displayImageURL:URL?
    let location:String?
    
    init(userDictionary:NSDictionary)
    {
        self.name = userDictionary["name"] as? String
        self.twitterHandle = userDictionary["screen_name"] as? String
        self.displayImageURL = userDictionary["profile_image_url"] as? URL
        self.location = userDictionary["location"] as? String
    }
}
