//
//  CreditsViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/25/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    //backgroundColorVariables
    let titleBackGroundColor = UIColor(red: 28/256, green: 29/256, blue: 41/256, alpha: 1)
    let bodyBackgroundColor = UIColor(red: 31/256, green: 32/256, blue: 35/256, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = titleBackGroundColor
        self.view.backgroundColor = bodyBackgroundColor

}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
