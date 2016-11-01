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
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    let tableCellTextColor = UIColor(red: 138/256, green: 139/256, blue: 142/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    let separatorColor = UIColor.white//UIColor(red: 58/256, green: 58/256, blue: 62/256, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame:.zero)
        self.tableView.separatorColor = titleTextColor
        self.tableView.backgroundColor=UIColor.darkGray
        self.tableView.tableHeaderView?.backgroundColor=titleBackGroundColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView,
                            willDisplayHeaderView view: UIView,
                            forSection section: Int)
    {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = titleBackGroundColor
        tableView.sectionHeaderHeight=70
        header.textLabel?.textColor = titleTextColor
        header.alpha = 1.0 //make the header transparent
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        // Configure the cell...
        cell.textLabel?.font = UIFont(name:"Cousine-Regular", size:16)
        cell.backgroundColor = bodyBackgroundColor
        cell.textLabel?.textColor = tableCellTextColor
        cell.textLabel?.text = "Hilllllo"
        var cellImage = UIImage(named: "LiverpoolAllBlack.png")
        if(indexPath.row == 0)
        {
            cellImage = UIImage(named: "User Groups-50.png")
            cell.textLabel?.text = "Manage Teams And Sources"
        }
        if(indexPath.row == 1)
        {
            cellImage = UIImage(named: "Twitter Filled-50.png")
            cell.textLabel?.text = "Manage Active Logins"
        }
        if(indexPath.row == 2)
        {
            cellImage = UIImage(named: "Contact Card Filled-50.png")
            cell.textLabel?.text = "Developer Credits"
        }
        cell.imageView?.image = cellImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Start segue with index of cell clicked
        var segueIdentifier = ""
        if(indexPath.row == 0)
        {
            segueIdentifier = "showManageTeams"
        }
        if(indexPath.row == 1)
        {
            segueIdentifier = "showActiveLogins"
        }
        if(indexPath.row == 2)
        {
            segueIdentifier = "showDeveloperCredits"
        }

        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier != nil
        {
            print("hi")
        }

    }
    

}
