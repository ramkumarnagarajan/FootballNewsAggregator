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
    var trendingTopics:Array<Any> = [""]
    
    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    let tableCellTextColor = UIColor(red: 138/256, green: 139/256, blue: 142/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    let tableBackgroundImage = UIImage(named: "BlackBackground.png")
    
    //Twitter API End Points :
    let showTrendsEndPoint = "https://api.twitter.com/1.1/trends/place.json?"
    let getWoeidEndPoint = "https://api.twitter.com/1.1/trends/closest.json?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TRENDING"
        self.navigationController?.navigationBar.tintColor = titleTextColor
        var currentLat:Double = 13.0827
        var currentLong:Double = 80.2703
        var woeid:Int64 = 1
        
        woeid = getCurrentLatAndLongAndWoeid(currentLat: currentLat,currentLong: currentLong)
    }
    
    
    func getCurrentLatAndLongAndWoeid(currentLat:Double,currentLong:Double) -> Int64 {

        let client = TWTRAPIClient()
        let params = ["lat":"\(currentLat)","long":"\(currentLong)"]
        var clientError : NSError?
        let tweetsRequest = client.urlRequest(withMethod: "GET", url: self.getWoeidEndPoint, parameters: params, error: &clientError)
        var currWoeid:Int64 = 1 // One for the World level
        client.sendTwitterRequest(tweetsRequest) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
                return
            }
            
            do
            {
                let result  = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [NSDictionary]
                currWoeid = result.first?["woeid"] as! Int64
                print(currWoeid)
                self.getTrendsNearThePlace(woeid: currWoeid)
            }
                
            catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
                currWoeid = 1
            }
        }
        return currWoeid
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // Get all the Entity Objects Stored and return the number
        //tableView.reloadData()
        if(self.trendingTopics.count<=1)
        {
            return 1
        }
        else
        {
            return self.trendingTopics.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TrendsCellIdentifier"))! as UITableViewCell
        cell.textLabel?.font = UIFont(name:"Cousine-Regular", size:16)
        cell.textLabel?.textColor = tableCellTextColor
        // Configure the cell...
        if(!self.trendingTopics.isEmpty && self.trendingTopics.count>1)
        {
            let strTopicName = "#".appending(self.trendingTopics[(indexPath as NSIndexPath).item] as! String)
            if(!strTopicName.isEmpty)
            {
                cell.textLabel?.text = strTopicName
            }
        }
        else if(self.trendingTopics.count<2){
            //do nothing..
            cell.textLabel?.text="no trending topics found"
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        let imageView = UIImageView(image: tableBackgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
        tableView.tableFooterView = UIView(frame:.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getTrendsNearThePlace(woeid: Int64)
    {
        
        let client = TWTRAPIClient()
        let params = ["exclude":"hashtags","id":"\(woeid)"]
        print("Printing WOEID from getTrendsNearThePlace method : \(woeid)")
        var clientError : NSError?
        let tweetsRequest = client.urlRequest(withMethod: "GET", url: self.showTrendsEndPoint, parameters: params, error: &clientError)
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
                    self.trendingTopics.insert(Obj["name"] as Any,at:iCounter)
                    iCounter = iCounter+1
                }
                self.tableView.reloadData()
                self.tableView.tableFooterView = UIView(frame:.zero)
            } catch let jsonError as NSError {
                    print("json error: \(jsonError.localizedDescription)")
                }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let segueIdentifier = "showDetail"
        var strSelectedHashTag = ""
        strSelectedHashTag = (trendingTopics[(indexPath as NSIndexPath).item] as AnyObject).capitalized
        print(strSelectedHashTag)
        // Start segue with index of cell clicked
        //self.performSegue(withIdentifier: segueIdentifier, sender: self)
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
