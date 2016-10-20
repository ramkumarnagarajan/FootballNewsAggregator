//
//  ManageTeamsViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/4/15.
//  Copyright © 2015 Ram. All rights reserved.
//

import UIKit
import CoreData

class ManageTeamsViewController: UITableViewController {

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
        
        let addTeamButton : UIBarButtonItem = UIBarButtonItem(image:UIImage(named:"BluePlusIcon"),  style: UIBarButtonItemStyle.plain, target: self, action: #selector(ManageTeamsViewController.addButtonPressed(_:)))
        
        let buttons : NSArray = [addTeamButton,self.editButtonItem]
        
        self.navigationItem.rightBarButtonItems = (buttons as! [UIBarButtonItem])
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
    }
    
    
    func addButtonPressed(_ sender:AnyObject){
        print("Add Button Pressed")
        //Show an alert to display 3 text boxes and 2 buttons
        //
        let alertSaveButton = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: handleAdd)
        let alertCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let alert = UIAlertController(title: "Team Information", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField(configurationHandler: configureTeamNameTextField)
        alert.addTextField(configurationHandler: configureSourceNameTextField)
        alert.addTextField(configurationHandler: configureSourceURLTextField)
        
        alert.addAction(alertSaveButton)
        alert.addAction(alertCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureSourceURLTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter Source URL"
        self.txtSourceURL = textField
    }
    
    func configureSourceNameTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter Source Name"
        self.txtSourceName = textField
    }
    
    
    func configureTeamNameTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter Team Name"
        self.txtTeamName = textField
    }
    
    func handleAdd(_ alertActionSave: UIAlertAction!)
    {
        print("Inside ManageTeamsViewController.handleAdd")
        let teamName = self.txtTeamName.text
        print("Entered Team is " + teamName!)
        
        let sourceName = self.txtSourceName.text
        print("Entered source-name is " + sourceName!)
        
        
        let sourceURL = self.txtSourceURL.text
        print("Entered source URL is " + sourceURL!)
        
        //Save the content as coreData -> Easy For retrieval
        let blnDataSaved = Team().saveData(teamName!, sourceName: sourceName!, sourceURL: sourceURL!)
        //Show an alert with success / failureMessage
        var alert = UIAlertController()
        var alertSaveButton = UIAlertAction()
        if(blnDataSaved)
        {
            
            //need to refresh the table, insert the new team into the table
            alertSaveButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert = UIAlertController(title: "Saved Successfully ", message: "Save Did  Completed Successfully..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(alertSaveButton)
            
        }
        else
        {
            //show alert with error
            alertSaveButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert = UIAlertController(title: "Save Failed", message: "Save Did Not Complete Successfully..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(alertSaveButton)
            
        }
        self.present(alert, animated: true, completion:nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var vwBackgroundView: UITableView!
    // MARK: - Table view data source

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
            return matchingEntities.count
        }
    }

    @IBAction func btnAddNewTeam(_ sender: AnyObject) {
    
        
    }

   
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = (tableView.dequeueReusableCellWithIdentifier("CellIdentifier"))! as UITableViewCell
        let teams : [Team] = Team().getStoredObjects("")
        let cell = UITableViewCell()

        // Configure the cell...
        cell.textLabel?.text="No Teams Found..Please add few.."
        if(!teams.isEmpty && teams.count>0)
        {
            cell.textLabel?.text = teams[(indexPath as NSIndexPath).item].teamName
        }
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
   
       
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}