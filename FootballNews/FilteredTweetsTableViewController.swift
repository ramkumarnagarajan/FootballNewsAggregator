//
//  FilteredTweetsTableViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/15/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import TwitterKit


class FilteredTweetsTableViewController: TWTRTimelineViewController {
    var strTwitterSource : String = ""
    var strSourceName : String = ""
    var blnIsFiltersDisplayed : Bool = false
    
    var txtTweetContainsWordOrHashTag : UITextField = UITextField()
    var txtMood : UITextField = UITextField()
    var txtSinceDate : UITextField = UITextField()
    var txtLocation : UITextField = UITextField()
    
    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    let tableCellTextColor = UIColor(red: 138/256, green: 139/256, blue: 142/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    let tableBackgroundImage = UIImage(named: "LiverpoolAllBlack.png")
    
    
    @IBOutlet weak var btnShowTrends: UIBarButtonItem!
    @IBOutlet weak var btnShowFilters: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(strTwitterSource)"
        print(self.title!)
        setDataSource(strTwitterQuery: self.strTwitterSource)
    }

    func setDataSource(strTwitterQuery:String)
    {
        let client = TWTRAPIClient()
        print("$$$$$$$ \(strTwitterQuery) ")
        if(strTwitterQuery.hasPrefix("@"))
        {
            let ds = TWTRUserTimelineDataSource(screenName: strTwitterQuery, apiClient: client)
            self.dataSource = ds
        }
        else
        {
            let ds = TWTRSearchTimelineDataSource(searchQuery: strTwitterQuery, apiClient: client)
            self.dataSource = ds
            
        }
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        TWTRTweetView.appearance().theme = .dark
        if(self.strTwitterSource.hasPrefix("@"))
        {
            btnShowTrends.isEnabled = false
            btnShowFilters.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showFilterOptions(_ sender: AnyObject) {
        let alertSaveButton = UIAlertAction(title: "Apply Filters", style: UIAlertActionStyle.default, handler:addFilters)
        let alertCancel = UIAlertAction(title: "Clear", style: UIAlertActionStyle.cancel, handler: clearFilters)
        
        let alert = UIAlertController(title: "Pick Your Filters", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        
        alert.addTextField(configurationHandler: configureSourceNameTextField)
        alert.addTextField(configurationHandler: configureSourceURLTextField)
        alert.addTextField(configurationHandler: configureSinceDateTextField)
        alert.addTextField(configurationHandler: configureLocationTextField)
        
        alert.addAction(alertSaveButton)
        alert.addAction(alertCancel)
        
        self.present(alert, animated: true, completion: nil)
    }

    func configureLocationTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter location [Eg: SF]"
        self.txtLocation = textField
    }

    
    func configureSourceURLTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter Mood [Eg: :) Or :( ]"
        self.txtMood = textField
    }
    
    func configureSinceDateTextField(_ textField: UITextField!)
    {
        textField.placeholder="Filter For Updates Since [YYYY-MM-DD]"
        self.txtSinceDate = textField
    }
    
    func configureSourceNameTextField(_ textField: UITextField!)
    {
        textField.placeholder="Contains Word or HashTag"
        self.txtTweetContainsWordOrHashTag = textField
    }
    
    func addFilters(_ alertActionSave: UIAlertAction!)
    {
        let strCurrentTwitterSource = self.strTwitterSource
        let strMood : String? = self.txtMood.text
        let strContains : String? = self.txtTweetContainsWordOrHashTag.text
        let strSinceDate : String? = self.txtSinceDate.text
        let updatedQuery : NSMutableString = NSMutableString(string:strCurrentTwitterSource)
        if(!strMood!.isEmpty)
        {
            updatedQuery.insert(" " , at: updatedQuery.length)
            updatedQuery.append(strMood!)
        }
        if(!strContains!.isEmpty)
        {
            updatedQuery.insert(" " , at: updatedQuery.length)
            updatedQuery.append(strContains!)
        }
        if(!strSinceDate!.isEmpty)
        {
            updatedQuery.insert(" " , at: updatedQuery.length)
            updatedQuery.append(strSinceDate!)
        }
        
        setDataSource(strTwitterQuery: updatedQuery.substring(from: 0))
        
    }
    
    func clearFilters(_ alertActionCancel : UIAlertAction!)
    {
        setDataSource(strTwitterQuery: self.strTwitterSource)
    }
}
