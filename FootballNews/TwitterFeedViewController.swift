//
//  TwitterFeedViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/30/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterFeedViewController: TWTRTimelineViewController {
   
    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    let tableCellTextColor = UIColor(red: 138/256, green: 139/256, blue: 142/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    let tableBackgroundImage = UIImage(named: "LiverpoolAllBlack.png")
    
    
    //Twitter API End Points :
    let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/show.json"
    let tweetsShowEndPoint = "https://api.twitter.com/1.1/search/tweets.json?"
    let geoCodeEndPoint = "https://api.twitter.com/1.1/geo/search.json?"
    
    //Class variable for twitter screenName to follow
    var strScreenName = ""
    var strTeamName = ""
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient()
       
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)");
                self.userId = (session?.userID)!
                
                if(self.strScreenName.hasPrefix("@"))
                {
                    let ds = TWTRUserTimelineDataSource(screenName: self.strScreenName, apiClient: client)
                    self.dataSource = ds
                }
                else
                {
                    let ds = TWTRSearchTimelineDataSource(searchQuery: self.strScreenName, apiClient: client)
                    self.dataSource = ds
                }
                
            } else {
                print("error: \(error?.localizedDescription)");
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.title = strTeamName.appending(" - Timeline")
        TWTRTweetView.appearance().theme = .dark
    }
    
    @IBAction func viewGraphs(_ sender: AnyObject) {
        let graphVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowTrendViewController") as! ShowTrendViewController
        graphVC.strSourceName = self.strScreenName
        self.navigationController?.pushViewController(graphVC, animated:true)

        
    }
    @IBAction func gotoFilteredTweets(_ sender: AnyObject) {
        
        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "FilteredTweetsViewController") as! FilteredTweetsTableViewController
        filterVC.strTwitterSource = self.strScreenName
        self.navigationController?.pushViewController(filterVC, animated:true)
    }
    
    
//    func getRestAPIData(twitterHandle:String )
//    {
//        if(!self.userId.isEmpty){
//        let client = TWTRAPIClient(userID: self.userId)
//        let tweetParams = ["q": twitterHandle.appending(" :("),"geocode":"37.6213,-122.3790,1000km","lang":"en"]
//        var clientError : NSError?
//        let tweetsRequest = client.urlRequest(withMethod: "GET", url: tweetsShowEndPoint, parameters: tweetParams, error: &clientError)
//            
//        client.sendTwitterRequest(tweetsRequest) { (response, data, connectionError) -> Void in
//            if connectionError != nil {
//                print("Error: \(connectionError)")
//                exit(0)
//            }
//            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String:AnyObject]
//                print("####################")
//                //print("json: \(json)")
//                let statuses = json["statuses"]
//                print("Status Count : \(statuses?.count)")
//                
//                let searchMetaData = json["search_metadata"]
//                print("Data items count: \(searchMetaData?.count)")
//                
//                let dataArray = json["statuses"] as! NSArray;
//                
//                print("Data items count: \(dataArray.count)")
//                for item in dataArray {
//                    // loop through data items
//                    let Obj = item as! NSDictionary
//                   
//                    let tweetObj1 = TweetsClass(tweetDictionary: Obj)
//                    print("Tweet Text : \(tweetObj1.tweetContent)")
//                    print("Tweet Location : \(tweetObj1.tweetedFromLocation)")
//                    print("Tweet User Name : \(tweetObj1.user?.name)")
//                    print("Tweet User Handle : \(tweetObj1.user?.twitterHandle)")
//                    print("Tweet User Location : \(tweetObj1.user?.location)")
//                }
//                //print(statuses?.contains("c"))
//            } catch let jsonError as NSError {
//                print("json error: \(jsonError.localizedDescription)")
//            }
//        }
//        }
//    }
    
}
