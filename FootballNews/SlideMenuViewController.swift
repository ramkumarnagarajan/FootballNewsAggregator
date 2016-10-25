//
//  SlideMenuViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/24/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit

class SlideMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame:.zero)
        self.tableView.backgroundColor=UIColor.darkGray
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
