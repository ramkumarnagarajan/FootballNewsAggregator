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
    var txtSourceName:UITextField = UITextField()
    var txtSourceURL : UITextField = UITextField()
    
    
    @IBAction func showFilterOptions(_ sender: AnyObject) {
        print("Add Button Pressed")
        //Show an alert to display 3 text boxes and 2 buttons
        //
        let alertSaveButton = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: nil)
        let alertCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        let alert = UIAlertController(title: "Pick Your Filters", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        
        alert.addTextField(configurationHandler: configureSourceNameTextField)
        alert.addTextField(configurationHandler: configureSourceURLTextField)
        
        alert.addAction(alertSaveButton)
        alert.addAction(alertCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureSourceURLTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter Source URL/Twitter ScreenName"
        self.txtSourceURL = textField
    }
    
    func configureSourceNameTextField(_ textField: UITextField!)
    {
        textField.placeholder="Enter Source Name"
        self.txtSourceName = textField
    }
    

    
    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    let tableCellTextColor = UIColor(red: 138/256, green: 139/256, blue: 142/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    let tableBackgroundImage = UIImage(named: "LiverpoolAllBlack.png")
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filters For \(strTwitterSource)"
        setDataSource()
    }

    func setDataSource()
    {
        let client = TWTRAPIClient()
        if(self.strTwitterSource.contains("@"))
        {
            let ds = TWTRUserTimelineDataSource(screenName: self.strTwitterSource, apiClient: client)
            self.dataSource = ds
        }
        else
        {
            let ds = TWTRSearchTimelineDataSource(searchQuery: self.strTwitterSource, apiClient: client)
            self.dataSource = ds
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        TWTRTweetView.appearance().theme = .dark
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
