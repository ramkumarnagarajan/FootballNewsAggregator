//
//  ViewTeamUpdatesViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/12/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import CoreData

class ViewTeamUpdatesTeamsViewController: UITableViewController,UISearchResultsUpdating
{
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

    //Class Variables
    var txtTeamName:UITextField = UITextField()
    var txtSourceName:UITextField = UITextField()
    var txtSourceURL : UITextField = UITextField()
    let allTeams : [Team] = Team().getStoredObjects("")
    
    //Search Controller variables
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTeams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
    
        searchController.searchResultsUpdater=self
        searchController.dimsBackgroundDuringPresentation=false
        definesPresentationContext=true
        tableView.tableHeaderView=searchController.searchBar
    }

    func filterContentForSearchText(searchText:String,scope:String="All")
    {
        print(allTeams.count)
        filteredTeams = allTeams.filter{team in
            return team.teamName.lowercased().contains(searchText.lowercased())}
        print(filteredTeams.count)
        tableView.reloadData()
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
        // #warning Incomplete implementation, return the number of rows
        // Get all the Entity Objects Stored and return the number
        //tableView.reloadData()
        let matchingEntities = Team().getStoredObjects("")
        if(matchingEntities.isEmpty)
        {
            return 1
        }
        else
        {
            if searchController.isActive && searchController.searchBar.text != "" {
                return filteredTeams.count
            }
            return matchingEntities.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = (tableView.dequeueReusableCellWithIdentifier("CellIdentifier"))! as UITableViewCell
        let teams : [Team] = Team().getStoredObjects("")
        let cell = UITableViewCell()
        // Configure the cell...
        cell.textLabel?.text="No Teams Found..Please add few.."
        
        var t: Team
        if searchController.isActive && searchController.searchBar.text != "" {
            if(!filteredTeams.isEmpty && filteredTeams.count>0)
            {
                t = filteredTeams[indexPath.row]
                cell.textLabel?.text=t.teamName
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.cyan.cgColor
            }
        }
        else
        {
            if(!teams.isEmpty && teams.count>0)
            {
                cell.textLabel?.text = teams[(indexPath as NSIndexPath).item].teamName
            }

        }
        cell.backgroundColor=UIColor.black
        cell.textLabel?.textColor=UIColor.white
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let teams = Team().getStoredObjects("")
            if(teams.count == 0)
            {
                return
            }
            let sourceURL = teams[(indexPath as NSIndexPath).item].sourceURL
            if(!sourceURL.isEmpty)
            {
                let isRowDeleted = Team().deleteEntity(sourceURL)
                if(isRowDeleted)
                {
                    print("row deleted : " + sourceURL)
                }
            }
            // Delete the row from Table
            tableView.reloadData()
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            //tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}
