//
//  ManageAccountsViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 9/27/15.
//  Copyright © 2015 Ram. All rights reserved.
//

import UIKit

class ManageAccountsViewController: UIViewController {

    @IBOutlet weak var vwBackgroundView: UIView!
    @IBOutlet weak var btnHome: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnHome.isEnabled = false
        btnHome.isHidden = true
        vwBackgroundView.layer.borderWidth = 1
        vwBackgroundView.layer.borderColor = UIColor.blue.cgColor
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func gotoHomeScreen(_ sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var homeVC = ViewController()
        homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! ViewController
        homeVC.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
