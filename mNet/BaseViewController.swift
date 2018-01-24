//
//  BaseViewController.swift
//  Konnect
//
//  Created by Anurag Jadhav on 10/23/17.
//  Copyright © 2017 Konnect. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var transperantLoadingOnVC :UIView?
    var loadingViewOnVC : UIView?
    var transaperantLoadingViewOnWindow : UIView?
    var loadingViewOnWindow : UIView?
    
    var tapGestureToMoveKbDown : UITapGestureRecognizer?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //add keyboard notificaton listner
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        tapGestureToMoveKbDown =  UITapGestureRecognizer.init(target: self, action: #selector(moveKeyboardDown(gesture:)))
    }
    
    
    //MARK: Navigation Bar Setup
    func showLargeTitle() {

        guard let baseNavigationController:BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        baseNavigationController.showLargeTitles()
    }

    func hideLargeTitle() {

        guard let baseNavigationController:BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        baseNavigationController.hideLargeTitles()
    }
    
    //MARK: Loading view methods

    //show gray loader on white background on VC
    func showLoadingOnViewController() {
        
        var tabBarHeight:CGFloat = 0
        
        if(self.loadingViewOnVC != nil) {
            
            if(self.tabBarController != nil){
                
                tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
            }
            
            self.loadingViewOnVC = UIView.init(frame: CGRect(x:self.view.frame.origin.x,y:self.view.frame.origin.y,width :self.view.frame.size.width,height :self.view.frame.size.height - tabBarHeight))
            self.loadingViewOnVC?.backgroundColor = UIColor.white
            self.loadingViewOnVC?.alpha = 1
            self.loadingViewOnVC?.center = CGPoint(x : self.view.frame.size.width/2, y :(self.view.frame.size.height - tabBarHeight)/2)
            
            let indicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
            indicator.center = (self.loadingViewOnVC?.center)!
            indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            indicator.startAnimating()
            indicator.color = UIColor.black
            
            
            self.loadingViewOnVC?.addSubview(indicator)
        }
        
        self.view.addSubview(self.loadingViewOnVC!)
    }
    
    //show gray loader on white background on Window

    func showLoadingOnWindow() {
        
        let appDelegate:AppDelegate = AppDelegate.appDelegate()
        
        if(self.loadingViewOnWindow != nil){
            
            self.loadingViewOnWindow = UIView.init(frame:(appDelegate.window?.frame)!)
            self.loadingViewOnWindow?.backgroundColor = UIColor.white
            self.loadingViewOnWindow?.alpha = 1
            self.loadingViewOnWindow?.center = (appDelegate.window?.center)!
            
            let indicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
            indicator.center = (self.loadingViewOnWindow?.center)!
            indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            indicator.startAnimating()
            indicator.color = UIColor.black
            
            self.loadingViewOnWindow?.addSubview(indicator)
        }
        
        appDelegate.window?.addSubview(self.loadingViewOnWindow!)
    }
    
    
    //show gray loader on transperant background on VC

    func showTransperantLoadingOnViewController() {
        
        var tabBarHeight:CGFloat = 0
        
        if(self.transperantLoadingOnVC != nil){
            
            if(self.tabBarController != nil){
                
                tabBarHeight = (self.tabBarController?.tabBar.frame.size.height)!
            }
            
            self.transperantLoadingOnVC = UIView.init(frame: CGRect(x:self.view.frame.origin.x,y:self.view.frame.origin.y,width :self.view.frame.size.width,height :self.view.frame.size.height - tabBarHeight))
            self.transperantLoadingOnVC?.backgroundColor = UIColor.lightGray
            self.transperantLoadingOnVC?.alpha = 0.3
            self.transperantLoadingOnVC?.center = CGPoint(x : self.view.frame.size.width/2, y :(self.view.frame.size.height - tabBarHeight)/2)
            
            let indicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
            indicator.center = (self.transperantLoadingOnVC?.center)!
            indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            indicator.startAnimating()
            indicator.color = UIColor.black
            
            
            self.transperantLoadingOnVC?.addSubview(indicator)
        }
        
        self.view.addSubview(self.transperantLoadingOnVC!)
    }
    
    //show gray loader on transperant background on Window

    func showTransperantLoadingOnWindow() {
        
        let appDelegate:AppDelegate = AppDelegate.appDelegate()
        
        if(self.transaperantLoadingViewOnWindow != nil){
            
            self.transaperantLoadingViewOnWindow = UIView.init(frame:(appDelegate.window?.frame)!)
            self.transaperantLoadingViewOnWindow?.backgroundColor = UIColor.lightGray
            self.transaperantLoadingViewOnWindow?.alpha = 0.3
            self.transaperantLoadingViewOnWindow?.center = (appDelegate.window?.center)!
            
            let indicator : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.gray)
            indicator.center = (self.transaperantLoadingViewOnWindow?.center)!
            indicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            indicator.startAnimating()
            indicator.color = UIColor.black
            
            self.transaperantLoadingViewOnWindow?.addSubview(indicator)
        }
        
        appDelegate.window?.addSubview(self.transaperantLoadingViewOnWindow!)
    }
    
    func removeLoadingFromViewController() {
        
        self.loadingViewOnVC?.removeFromSuperview()
    }
    
    
    func removeLoadingFromWindow() {
        
        self.loadingViewOnWindow?.removeFromSuperview()
    }
    
    func removeTransperantLoadingFromViewController() {
        
        self.transperantLoadingOnVC?.removeFromSuperview()
    }
    
    
    func removeTransperantLoadingFromWindow() {
        
        self.transaperantLoadingViewOnWindow?.removeFromSuperview()
    }
    
    //MARK: Keyboard notification listners
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        
        //add gesture recognizer
        self.view.addGestureRecognizer(self.tapGestureToMoveKbDown!)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            if let foundScrollView = view.viewWithTag(12345) {
                
                let contentInsets : UIEdgeInsets =  UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 30 , 0.0)
                let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double)
              
                UIView.animate(withDuration: animationDuration!, animations: {
                    
                    (foundScrollView as! UIScrollView).contentInset = contentInsets
                    (foundScrollView as! UIScrollView).scrollIndicatorInsets = contentInsets
                })
            }
        }
    }
    
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        
        //add gesture recognizer
        self.view.removeGestureRecognizer(self.tapGestureToMoveKbDown!)
        
        if let foundScrollView = view.viewWithTag(12345) {
            
            let contentInsets : UIEdgeInsets =  UIEdgeInsets.zero
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double)
            
            UIView.animate(withDuration: animationDuration!, animations: {
                
                (foundScrollView as! UIScrollView).contentInset = contentInsets
                (foundScrollView as! UIScrollView).scrollIndicatorInsets = contentInsets
                (foundScrollView as! UIScrollView).contentOffset = CGPoint.zero;
            })
        }
    }
    
    
    //MARK: Gesture recognizer methods
    
    @objc func moveKeyboardDown(gesture:UITapGestureRecognizer){
        
        self.view.endEditing(true)
    }

}
