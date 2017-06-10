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
    let tableCellTextColor = UIColor(red: 138/256, green: 139/256, blue: 142/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    let tableBackgroundImage = UIImage(named: "BlackBackground.png")
    
    //Class Variables
    let allTeams : [Team] = Team().getStoredObjects("")
    var strSourceURL = ""
    var strTeamName = ""
    
    
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
        tableView.tableFooterView = UIView(frame: .zero)
        searchController.searchBar.placeholder="Filter"
        searchController.searchResultsUpdater=self
        searchController.dimsBackgroundDuringPresentation=false
        definesPresentationContext=true
        tableView.tableHeaderView=searchController.searchBar
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellMain")
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.navigationController?.navigationBar.isOpaque = true
        if revealViewController() != nil
        {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            //self.revealViewController().rearViewRevealWidth = 400
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.view.backgroundColor = bodyBackgroundColor
        let imageView = UIImageView(image: tableBackgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
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
        var strTeamName = ""
        
        // Configure the cell...
        cell.textLabel?.text="No tabs Found..Please add a few.."
        cell.textLabel?.font = UIFont(name:"Cousine-Regular", size:16)
        
        var t: Team
        if searchController.isActive && searchController.searchBar.text != "" {
            if(!filteredTeams.isEmpty && filteredTeams.count>0)
            {
                t = filteredTeams[indexPath.row]
                strTeamName = t.teamName.capitalized
                
                //Some indication that this result is filtered..
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.cyan.cgColor
            }
        }
        else
        {
            if(!teams.isEmpty && teams.count>0)
            {
                strTeamName = teams[(indexPath as NSIndexPath).item].teamName.capitalized
            }
            
        }
        cell.textLabel?.text = strTeamName
        cell.backgroundColor=UIColor.clear
        cell.textLabel?.textColor = tableCellTextColor

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.backgroundColor = bodyBackgroundColor.withAlphaComponent(1)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let teams : [Team] = allTeams
        var segueIdentifier = "showDetail"
        var strTeamName = ""
        
        var t: Team
        if searchController.isActive && searchController.searchBar.text != "" {
            if(!filteredTeams.isEmpty && filteredTeams.count>0)
            {
                t = filteredTeams[indexPath.row]
                strTeamName = t.teamName.capitalized
                
                self.strTeamName = strTeamName
                self.strSourceURL = t.sourceURL
                
                
                print(strTeamName)
            }
        }
        else
        {
            if(!teams.isEmpty && teams.count>0)
            {
                strTeamName = teams[(indexPath as NSIndexPath).item].teamName.capitalized
                self.strTeamName = strTeamName
                self.strSourceURL = teams[(indexPath as NSIndexPath).item].sourceURL
                
                print(strTeamName)
            }
            
        }
        if(strSourceURL.contains("#") || strSourceURL.contains("@"))
        {
            //performSegue for twitter view controller.
            segueIdentifier = "showTwitterDetail"
        }
        // Start segue with index of cell clicked
        self.performSegue(withIdentifier: segueIdentifier, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier
        {
            if (identifier.contains("showDetail"))
            {
                let detailVC = segue.destination as! WebViewController
                detailVC.strTeamURL = strSourceURL
                detailVC.strTeamName = strTeamName
                
                print("Prepare for segue called")
            }
            
            if(identifier.contains("showTwitterDetail"))
            {
                let detailVC = segue.destination as! FilteredTweetsTableViewController
                detailVC.strTwitterSource = strSourceURL
                detailVC.strSourceName = strTeamName
                
                print("Prepare for segue called")
                
            }
        }
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}
