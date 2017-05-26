//
//  WebViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 5/25/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import Foundation
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

class WebViewController:UIViewController,UIWebViewDelegate{
    var strTeamName=""
    var strTeamURL=""
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail View Controller loaded")
        print(strTeamName)
        print(strTeamURL)
        webView.scalesPageToFit = true
        let url = NSURL (string: strTeamURL)
        let requestObj = NSURLRequest(url: url! as URL);
        webView.loadRequest(requestObj as URLRequest);
        webView.scalesPageToFit = true
        self.title = strTeamName
        webView.resizeWebContent()
        self.webView.contentMode = UIViewContentMode.scaleAspectFit
    }
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        if(webView.canGoBack){
            webView.goBack()
        }
        
    }
    @IBAction func goForward(_ sender: UIBarButtonItem) {
        if(webView.canGoForward){
            webView.goForward()
        }
    }
}
