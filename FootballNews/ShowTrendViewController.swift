//
//  ShowTrendViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 11/15/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit
import Charts



class ShowTrendViewController: UIViewController {
    var strSourceName:String = ""
    var locations: [String]!

    @IBOutlet weak var barChartView: BarChartView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trend For \(strSourceName)"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
