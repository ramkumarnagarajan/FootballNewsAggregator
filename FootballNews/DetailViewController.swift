//
//  DetailViewController.swift
//  FootballNews
//
//  Created by Kanti Krishnan on 10/26/16.
//  Copyright © 2016 Ram. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController,UIWebViewDelegate {

    var strTeamName=""
    var strTeamURL=""
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
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
        //setupWebViewNavButtons()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var webViewBackButton: UIBarButtonItem!
    func setupWebViewNavButtons()
    {
        if(!webView.canGoBack)
        {
            webViewBackButton.isEnabled = false
        }
        if(webView.canGoBack){
            webViewBackButton.isEnabled = true
        }
        if(!webView.canGoForward){
            webViewFwdButton.isEnabled = false
        }
        if(webView.canGoForward)
        {
            webViewFwdButton.isEnabled=true
        }
    }
  
    @IBOutlet weak var webViewFwdButton: UIBarButtonItem!
    @IBAction func goBack(_ sender: Any) {
        if(webView.canGoBack){
            webView.goBack()
        }
        setupWebViewNavButtons()
    }
    
    @IBAction func goForward(_ sender: Any) {
        if(webView.canGoForward){
            webView.goForward()
        }
        setupWebViewNavButtons()
        
    
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        loader.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loader.stopAnimating()
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
