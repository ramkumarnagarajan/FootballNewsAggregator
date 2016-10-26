//
//  TeamUpdatesViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/24/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import CoreData

class TeamUpdatesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating {

    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    
    //Class Variables
    let allTeams : [Team] = Team().getStoredObjects("")
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    //Search Controller variables
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTeams = [Team]()

    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText:String,scope:String="All")
    {
        filteredTeams = allTeams.filter{team in
            return team.teamName.lowercased().contains(searchText.lowercased())}
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
        tableView.tableFooterView = UIView(frame: .zero)
        searchController.searchResultsUpdater=self
        searchController.dimsBackgroundDuringPresentation=false
        definesPresentationContext=true
        tableView.tableHeaderView=searchController.searchBar
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellMain")
        self.tableView.backgroundColor=UIColor.black
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor

        if revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.revealViewController().rearViewRevealWidth = 500
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.view.backgroundColor = bodyBackgroundColor
        self.tableView.backgroundColor=bodyBackgroundColor
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                let strTeamName = t.teamName.capitalized
                let strSrcName = t.sourceName.capitalized
                
                cell.textLabel?.text = strTeamName.appending(" - ").appending(strSrcName)
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.cyan.cgColor
            }
        }
        else
        {
            if(!teams.isEmpty && teams.count>0)
            {
                let strTeamName = teams[(indexPath as NSIndexPath).item].teamName.capitalized
                let strSrcName = teams[(indexPath as NSIndexPath).item].sourceName.capitalized
                
                cell.textLabel?.text = strTeamName.appending(" - ").appending(strSrcName)
            }
            
        }
        cell.backgroundColor=bodyBackgroundColor
        cell.textLabel?.textColor=UIColor.white
        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
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
