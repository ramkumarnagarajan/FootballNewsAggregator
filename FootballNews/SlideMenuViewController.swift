//
//  SlideMenuViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/24/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit

class SlideMenuViewController: UITableViewController {

    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame:.zero)
        self.tableView.backgroundColor=UIColor.darkGray
        self.tableView.tableHeaderView?.backgroundColor=titleBackGroundColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
