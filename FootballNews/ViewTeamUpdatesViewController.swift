//
//  ViewTeamUpdatesViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/12/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import CoreData

class ViewTeamUpdatesTeamsViewController: UITableViewController {
    //Class Variables
    var txtTeamName:UITextField = UITextField()
    var txtSourceName:UITextField = UITextField()
    var txtSourceURL : UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
