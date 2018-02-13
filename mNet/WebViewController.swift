//
//  WebViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 14/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressBarHeight: NSLayoutConstraint!
    
    let timerInterval = 0.05
    var isLoading = false
    var loadingTimer = Timer()
    
    var urlToLoad:URL?
    var screenTitle:String = ConstantStrings.appName
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Setup
    func setData(url:URL?, header:String?) {
        
        urlToLoad = url
        screenTitle = header ?? ConstantStrings.appName
    }
    
    func setUpViewController() {
        
        self.navigationItem.title = screenTitle
        self.navigationController?.navigationBar.isHidden = false
        webView.delegate = self
        progressBar.progressTintColor = ColorConstants.kBlueColor
        progressBar.trackTintColor = ColorConstants.kBrownColor
        progressBar.tintColor = ColorConstants.kWhiteColor
        
        guard let url:URL = urlToLoad else {
            return
        }
        let urlRequest:URLRequest = URLRequest(url: url)
        webView.loadRequest(urlRequest)
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Web View Delegates
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        showProgressBar()
        loadingTimer = Timer.scheduledTimer(timeInterval:timerInterval , target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        hideProgressBar()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        hideProgressBar()
    }
    
    //MARK: Progress
    
    func hideProgressBar() {
        
        progressBarHeight.constant = 0
        UIView.animate(withDuration: 0.4) {
            
            self.view.layoutIfNeeded()
        }
        
        loadingTimer.invalidate()
        progressBar.setProgress(0, animated: false)
        isLoading = false
    }
    
    func showProgressBar() {
        
        progressBarHeight.constant = 2
        UIView.animate(withDuration: 0.4) {
            
            self.view.layoutIfNeeded()
        }
        isLoading = true
        progressBar.setProgress(0, animated: true)
    }
    
    func timerCallback() {
        
        if !isLoading {
            
            if progressBar.progress >= 1 {
                
                progressBar.isHidden = true
                loadingTimer.invalidate()
            }
                
            else {
                
                progressBar.setProgress(progressBar.progress + 0.1, animated: true)
            }
        }
            
        else {
            
            progressBar.progress += 0.05
            
            if progressBar.progress >= 0.95 {
                
                progressBar.progress = 0.95
            }
        }
    }
    
}
