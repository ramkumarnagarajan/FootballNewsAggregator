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


class ShowTrendViewController: UIViewController {
    var strSourceName:String = ""
    var locations: [String]!
    //Twitter API End Points :
    let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/show.json"
    let tweetsShowEndPoint = "https://api.twitter.com/1.1/search/tweets.json?"
    let geoCodeEndPoint = "https://api.twitter.com/1.1/geo/search.json?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trend For \(strSourceName)"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        func getRestAPIData(twitterHandle:String )
        {
            let client = TWTRAPIClient()
            let tweetParams = ["q": twitterHandle.appending(" :("),"geocode":"37.6213,-122.3790,1000km","lang":"en"]
            var clientError : NSError?
            let tweetsRequest = client.urlRequest(withMethod: "GET", url: tweetsShowEndPoint, parameters: tweetParams, error: &clientError)
    
            client.sendTwitterRequest(tweetsRequest) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                    exit(0)
                }
    
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]
                    print("####################")
                    //print("json: \(json)")
                    let statuses = json["statuses"]
                    print("Status Count : \(statuses?.count)")
    
                    let searchMetaData = json["search_metadata"]
                    print("Data items count: \(searchMetaData?.count)")
    
                    let dataArray = json["statuses"] as! NSArray;
    
                    print("Data items count: \(dataArray.count)")
                    for item in dataArray {
                        // loop through data items
                        let Obj = item as! NSDictionary
    
                        let tweetObj1 = TweetsClass(tweetDictionary: Obj)
                        print("Tweet Text : \(tweetObj1.tweetContent)")
                        print("Tweet Location : \(tweetObj1.tweetedFromLocation)")
                        print("Tweet User Name : \(tweetObj1.user?.name)")
                        print("Tweet User Handle : \(tweetObj1.user?.twitterHandle)")
                        print("Tweet User Location : \(tweetObj1.user?.location)")
                    }
                    //print(statuses?.contains("c"))
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
            
        }
}
