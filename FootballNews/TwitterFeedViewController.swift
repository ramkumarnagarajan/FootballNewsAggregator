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
    
    
    //Class variable for twitter screenName to follow
    var strScreenName = ""
    var strTeamName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        if(strScreenName.contains("@"))
        {   self.dataSource = TWTRUserTimelineDataSource(screenName: strScreenName, apiClient: client)
        }
        else
        {
            self.dataSource = TWTRSearchTimelineDataSource(searchQuery: strScreenName, apiClient: client)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.title = "Twitter Timeline for ".appending(strTeamName)
        TWTRTweetView.appearance().theme = .dark
    }
}
