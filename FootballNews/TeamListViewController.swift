//
//  TeamListViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 9/27/15.
//  Copyright © 2015 Ram. All rights reserved.
//

import UIKit

class TeamListViewController: UIViewController,UIPickerViewDelegate {

    @IBOutlet weak var vwBackgroundView: UIView!
    @IBOutlet weak var btnGoHome: UIButton!
    var cars = ["Audi","Lexus","Toyota","Honda"]
    var URLToLoad = Team.selectedSource
    @IBOutlet weak var myWebView: UIWebView!
    var teams:[String] = []
    var sources:[String] = []
    var pickerSource:[Team]=[]
    
    func loadURLToWebView()
    {
        let requestURL = URL(string: URLToLoad)
        let request = URLRequest(url: requestURL!)
        myWebView.loadRequest(request)
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerSource.isEmpty || pickerSource.count == 0)
        {
            return "No Data"
        }
        else
        {
            let teamAndSource = pickerSource[row].teamName + "->" + pickerSource[row].sourceName
            return teamAndSource
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)    // The number of rows of data
    {
        if(pickerSource.isEmpty || pickerSource.count < 1)
        {
            print("picker Did select row : pickerSource is empty")
            return
        }
        //get url to load for the selected item
        
        let url = pickerSource[row].sourceURL
        if(url.isEmpty)
        {
            Team.selectedSource = "" //no url is set
            print("TeamListViewController -> url is empty for selected team")
        }
        else
        {
            print("TeamListViewController -> selected url ->  " + url)

            Team.selectedSource=url
            URLToLoad=url
        }
        //reload the request
        loadURLToWebView()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let pickerSource = Team().getStoredObjects("")
        if(pickerSource.isEmpty || pickerSource.count == 0)
        {
            return 1
    
        }
        else
        {
            return pickerSource.count
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pickerSource = Team().getStoredObjects("")
        loadURLToWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGoHome.isHidden=true
        pickerSource = Team().getStoredObjects("")
        let viewBackGroundColor = UIColor(red:36/256,green:36/256,blue:36/256,alpha:1)
        self.view?.backgroundColor = viewBackGroundColor
        loadURLToWebView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goHome(_ sender: AnyObject) {
        btnGoHome.backgroundColor=UIColor.red
        
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
