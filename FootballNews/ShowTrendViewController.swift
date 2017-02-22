//
//  ShowTrendViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/15/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import Charts
import TwitterKit
import CoreLocation
import AddressBookUI


class ShowTrendViewController : UITableViewController{
    var strSourceName:String = ""
    var locations: [String]!
    var trendingTopics:Array<Any> = ["345","345"]
    
    //Twitter API End Points :
    let showTrendsEndPoint = "https://api.twitter.com/1.1/trends/place.json?id=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending World Topics"
        getTrendsForPlace(place: "Chennai")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getTrendsForPlace(place:String)
    {
        
        let client = TWTRAPIClient()
        let params = ["exclude":"hashtags","id":"1"]
        var clientError : NSError?
        let tweetsRequest = client.urlRequest(withMethod: "GET", url: showTrendsEndPoint, parameters: params, error: &clientError)
        client.sendTwitterRequest(tweetsRequest) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }

            do {
                let result  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [NSDictionary]
                let dataArray = result.first?["trends"] as! NSArray
                var iCounter:Int = 0
                for item in dataArray
                {
                    // loop through data items
                    let Obj = item as! NSDictionary
                    //print(Obj["name"]!)
                    self.trendingTopics.insert("\(Obj["name"])",at:iCounter)
                    iCounter = iCounter+1
                }
                
            } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
        }
    }

    
//    func getRestAPIData(twitterHandle:String,restAPIEndPoint:String)
//        {
//            let client = TWTRAPIClient()
//            let ttweetParams = ["q": twitterHandle.appending(" :("),"geocode":"37.6213,-122.3790,7000km","lang":"en","count":"100"]
//            var clientError : NSError?
//            let tweetsRequest = client.urlRequest(withMethod: "GET", url: restAPIEndPoint, parameters: ttweetParams, error: &clientError)
//
//            client.sendTwitterRequest(tweetsRequest) { (response, data, connectionError) -> Void in
//                if connectionError != nil {
//                    print("Error: \(connectionError)")
//                    exit(0)
//                }
//    
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]
//                    print("####################")
//                    //print("json: \(json)")
//                    let statuses = json["statuses"]
//                    print("Status Count : \(statuses?.count)")
//                    
//                    let searchMetaData = json["search_metadata"]
//                    print("Data items count: \(searchMetaData?.count)")
//    
//                    let dataArray = json["statuses"] as! NSArray;
//    
//                    print("Data items count: \(dataArray.count)")
//                    for item in dataArray {
//                        // loop through data items
//                        let Obj = item as! NSDictionary
//    
//                        let tweetObj1 = TweetsClass(tweetDictionary: Obj)
//                        print("Tweet Text : \(tweetObj1.tweetContent)")
//                        print("Tweet Location : \(tweetObj1.tweetedFromLocation)")
//                        print("Tweet User Name : \(tweetObj1.user?.name)")
//                        print("Tweet User Handle : \(tweetObj1.user?.twitterHandle)")
//                        print("Tweet User Location : \(tweetObj1.user?.location)")
//                    }
//                    //print(statuses?.contains("c"))
//                } catch let jsonError as NSError {
//                    print("json error: \(jsonError.localizedDescription)")
//                }
//            }
//            
//        }
}
