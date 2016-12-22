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


class ShowTrendViewController: TWTRTimelineViewController {
    var strSourceName:String = ""
    var locations: [String]!
    
    //Twitter API End Points :
    let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/show.json?"
    let tweetsShowEndPoint = "https://api.twitter.com/1.1/search/tweets.json?"
    let geoCodeEndPoint = "https://api.twitter.com/1.1/geo/search.json?"
    let trendsForPlaceEndPoint = "https://api.twitter.com/1.1/trends/closest.json?"
    let showTrendsEndPoint = "https://api.twitter.com/1.1/trends/place.json?id=23424975"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trend For \(strSourceName)"
        let client = TWTRAPIClient()
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "thewalkingdead", apiClient: client)
        //getRestAPIData(twitterHandle: "@lfc", restAPIEndPoint: tweetsShowEndPoint)
        getTrendsForPlace(place: "Chennai")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getTrendsForPlace(place:String)
    {
        //get the lat / long for the place.
//        let lat = 37.781157;
//        let long = -122.400612831116;
        //let woeid = "23424975"
        
        //get the WOEID for this lat / long
        let client = TWTRAPIClient()
        let params = ["exclude":"hashtags"]
        var clientError : NSError?
        let tweetsRequest = client.urlRequest(withMethod: "GET", url: showTrendsEndPoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(tweetsRequest) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(connectionError)")
                }
                
                do {
                    let json1 = try JSONSerialization.jsonObject(with: data!, options: [])
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                    var names = [String]()
                    if let trends = json?["trends"] as? [[String:Any]] {
                        for trend in trends {
                            if let name = trend["name"] as? String {
                                names.append(name)
                            }
                        }
                    }
                    print("HELLOW")
                    print(json1)
                } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }        }

        //call the showTrends End points with this woeid.
        //assign the json as datasource.
    }
    
    func getRestAPIData(twitterHandle:String,restAPIEndPoint:String)
        {
            let client = TWTRAPIClient()
            let ttweetParams = ["q": twitterHandle.appending(" :("),"geocode":"37.6213,-122.3790,7000km","lang":"en","count":"100"]
            var clientError : NSError?
            let tweetsRequest = client.urlRequest(withMethod: "GET", url: restAPIEndPoint, parameters: ttweetParams, error: &clientError)

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
