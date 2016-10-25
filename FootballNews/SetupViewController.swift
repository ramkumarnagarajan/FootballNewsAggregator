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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnHome.isEnabled=false
        btnHome.isHidden = true
        
        vwBackgroundView.layer.borderColor = UIColor.blue.cgColor
        vwBackgroundView.layer.borderWidth = 1
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
    }
    
    @IBOutlet weak var vwBackgroundView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func gotoManageTeams(_ sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var tlVC = ManageTeamsViewController()
        tlVC = storyBoard.instantiateViewController(withIdentifier: "ManageTeamsViewController") as! ManageTeamsViewController
        //tlVC.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.pushViewController(tlVC, animated: true)
    }
}
