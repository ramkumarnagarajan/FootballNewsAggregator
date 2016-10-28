//
//  SetupViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 9/19/15.
//  Copyright © 2015 Ram. All rights reserved.
//

import UIKit

class SetupViewController : UIViewController
{
    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    let titleTextColor = UIColor(red: 114/256, green: 132/256, blue: 148/256, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MANAGE ACTIVE LOGINS"
}
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.view.backgroundColor = bodyBackgroundColor
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
