//
//  TrendGraphViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 5/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation
import UIKit
import Charts

class TrendGraphViewController:UIViewController,ChartViewDelegate,IAxisValueFormatter
{
    let months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    let dollars1 = [1453.0,2352,5431,1442,5451,6887,2212,301,411,221,654]
    var chart: LineChartView!
    var dataSet: LineChartDataSet!
    var backButtonText:String=""
    
    @IBOutlet weak var lblHashTag: UILabel!

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Trend Graphs"
        // 1
        
        self.navigationController?.navigationItem.backBarButtonItem?.title = "hello"
        self.lineChartView.delegate = self as ChartViewDelegate
        // 2
        self.lineChartView.chartDescription?.text = "Tap node for details"
        // 3
        self.lineChartView.chartDescription?.textColor = UIColor.white
        self.lineChartView.gridBackgroundColor = UIColor.darkGray
        // 4
        self.lineChartView.noDataText = "No data provided"
        // 5
        setChartData(months: months)
        //setData()

    }

    func setChartData(months : [String]) {
        let values: [Double] = [8,22,44,48,77,14, 81, 71, 10, 41, 45, 61]
        
        var entries: [ChartDataEntry] = Array()
        
        for (i, value) in values.enumerated()
        {
            entries.append(ChartDataEntry(x: Double(i), y: value))
        }
        
        dataSet = LineChartDataSet(values: entries, label: "First unit test data")
        dataSet.axisDependency = .left // Line will correlate with left axis values
        dataSet.setColor(UIColor.purple.withAlphaComponent(0.5)) // our line's opacity is 50%
        dataSet.setCircleColor(UIColor.red) // our circle will be dark red
        dataSet.lineWidth = 1.0
        dataSet.circleRadius = 3.0 // the radius of the node circle
        dataSet.fillAlpha = 65 / 255.0
        dataSet.fillColor = UIColor.red
        
        dataSet.highlightColor = UIColor.white
        dataSet.drawCircleHoleEnabled = true
        
        lineChartView.data = LineChartData(dataSet: dataSet)
        let yaxis = lineChartView.getAxis(YAxis.AxisDependency.right)
        yaxis.drawLabelsEnabled = false
        lineChartView.backgroundColor = NSUIColor.clear
        lineChartView.leftAxis.axisMinimum = 0.0
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        lineChartView.xAxis.valueFormatter = self as IAxisValueFormatter;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String
    {
        return months[Int(value)];  // Return you label string, from an array perhaps.
    }

}
