//
//  TweetsClass.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/13/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import Foundation

class TweetsClass
{
    let user:TweetUser?
    let postedTime:NSDate?
    let tweetContent:String?
    //let associatedHashTags:[String]?
    //let associatedTweetHandles:[String]?
    let tweetedFromLocation:String?
    
    init(tweetDictionary:NSDictionary)
    {
        self.user = TweetUser(userDictionary: tweetDictionary["user"] as! NSDictionary)
        self.postedTime = tweetDictionary["created_at"] as? NSDate
        self.tweetContent = tweetDictionary["text"] as? String
        self.tweetedFromLocation = tweetDictionary["place"] as? String
    }
}
