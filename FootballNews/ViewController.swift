//
//  ViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 9/19/15.
//  Copyright © 2015 Ram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var vwBackgroundView: UIView!
    @IBOutlet weak var ivHomeScreen: UIImageView!
    var txtTeamName:UITextField = UITextField()
    var txtSourceName:UITextField = UITextField()
    var txtSourceURL : UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let navBarBackgroundColor = UIColor(red:0,green:172/256,blue:237/256,alpha:1)
        navigationController?.navigationBar.barTintColor = navBarBackgroundColor
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.white
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
    }

    @IBAction func btnShowLiverpoolUpdates(_ sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var viewUpdatesVC  = TeamListViewController();
        Team.selectedSource="https://www.facebook.com/LiverpoolFC/"
        viewUpdatesVC = storyBoard.instantiateViewController(withIdentifier: "TeamListViewController") as! TeamListViewController;
        self.navigationController?.pushViewController(viewUpdatesVC, animated: true)
    }
    
    @IBAction func btnAddNewTeamAndSource(_ sender: AnyObject) {
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
            alert = UIAlertController(title: "Saved Successfully ", message: teamName!+" -> Save Completed Successfully..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(alertSaveButton)
            
        }
        else
        {
            //show alert with error
            alertSaveButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert = UIAlertController(title: "Save Failed", message: "Save Errored..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(alertSaveButton)
            
        }
        self.present(alert, animated: true, completion:nil)

    }
    
    
    @IBAction func btnGotoChelsea(_ sender: AnyObject) {
    
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var viewUpdatesVC  = TeamListViewController();
        Team.selectedSource="https://www.facebook.com/ChelseaFC/"
        viewUpdatesVC = storyBoard.instantiateViewController(withIdentifier: "TeamListViewController") as! TeamListViewController;
        self.navigationController?.pushViewController(viewUpdatesVC, animated: true)    }
   
    
    @IBAction func gotoMoreTeamUpdates(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var teamListVC  = TeamListViewController();
        var teamList = Team().getStoredObjects("")
        if(teamList.isEmpty)
        {
            print("ViewController.swift -> gotoMoreTeamUpdates -> first Team is empty..")
            //show alert with error
            var alert = UIAlertController()
            var alertSaveButton = UIAlertAction()

            alertSaveButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert = UIAlertController(title: "No Teams added", message: "No Team has been successfully added yet..Please add a team before viewing the updates..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(alertSaveButton)
        }
        else
        {
            let firstTeam = teamList.first
            if(firstTeam!.sourceURL.isEmpty)
            {
                print("ViewController.swift -> gotoMoreTeamUpdates -> first Team is empty..")
            }
            else
            {
                Team.selectedSource = (firstTeam?.sourceURL)!
                print("ViewController.swift -> gotoMoreTeamUpdates -> first Team URL is " + (firstTeam?.sourceURL)!)
                teamList.removeAll()
                teamListVC = storyBoard.instantiateViewController(withIdentifier: "TeamListViewController") as! TeamListViewController;
                self.navigationController?.pushViewController(teamListVC, animated: true)
            }
        }
        
    
    }
    func setupBorder()
    {
        ivHomeScreen.layer.borderColor = UIColor.white.cgColor;
        
        ivHomeScreen.layer.borderWidth = 0;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func setupViewController(_ sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var setupVC  = SetupViewController();
        setupVC = storyBoard.instantiateViewController(withIdentifier: "SetupViewController") as! SetupViewController;
        self.navigationController?.pushViewController(setupVC, animated: true)
    }
}

