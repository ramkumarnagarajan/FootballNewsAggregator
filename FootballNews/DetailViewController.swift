//
//  DetailViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/26/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit


extension UIWebView {
    ///Method to fit content of webview inside webview according to different screen size
    func resizeWebContent() {
        let contentSize = self.scrollView.contentSize
        let viewSize = self.bounds.size
        let zoomScale = viewSize.width/contentSize.width
        self.scrollView.minimumZoomScale = zoomScale
        self.scrollView.maximumZoomScale = zoomScale
        self.scrollView.zoomScale = zoomScale/2
    }
}

class DetailViewController: UIViewController {

    var strTeamName=""
    var strTeamURL=""
    
  
    
    @IBOutlet weak var webViewOutlet: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail View Controller loaded")
        print(strTeamName)
        print(strTeamURL)
        self.title = strTeamName.appending(" - UPDATES")
        webViewOutlet.loadRequest(NSURLRequest(url: NSURL(string: strTeamURL)! as URL) as URLRequest)
        webViewOutlet.resizeWebContent()

        // Do any additional setup after loading the view.
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
