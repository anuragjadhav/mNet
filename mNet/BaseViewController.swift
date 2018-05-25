//
//  BaseViewController.swift
//  Konnect
//
//  Created by Anurag Jadhav on 10/23/17.
//  Copyright © 2017 Konnect. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,RetryViewProtocol, UIGestureRecognizerDelegate {
    
    var transperantLoadingOnVC :UIView?
    var loadingViewOnVC : UIView?
    var transaperantLoadingViewOnWindow : UIView?
    var loadingViewOnWindow : UIView?
    var retryView : RetryView?
    var tapGestureToMoveKbDown : UITapGestureRecognizer?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tapGestureToMoveKbDown =  UITapGestureRecognizer.init(target: self, action: #selector(moveKeyboardDown(gesture:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //add keyboard notificaton listner
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        //for back swipe
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        //for handling tabbar
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

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
        
        if(self.loadingViewOnVC == nil) {
            
            self.loadingViewOnVC = UIView.init(frame: CGRect(x:self.view.frame.origin.x,y:self.view.frame.origin.y,width :self.view.frame.size.width,height :self.view.frame.size.height))
            self.loadingViewOnVC?.backgroundColor = UIColor.white
            self.loadingViewOnVC?.alpha = 1
            self.loadingViewOnVC?.center = CGPoint(x : self.view.frame.size.width/2, y :(self.view.frame.size.height)/2)
            
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
        
        let appDelegate:AppDelegate = AppDelegate.sharedInstance
        
        if(self.loadingViewOnWindow == nil){
            
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
        
        if(self.transperantLoadingOnVC == nil){
            
            self.transperantLoadingOnVC = UIView.init(frame: CGRect(x:self.view.frame.origin.x,y:self.view.frame.origin.y,width :self.view.frame.size.width,height :self.view.frame.size.height))
            self.transperantLoadingOnVC?.backgroundColor = UIColor.lightGray
            self.transperantLoadingOnVC?.alpha = 0.3
            self.transperantLoadingOnVC?.center = CGPoint(x : self.view.frame.size.width/2, y :(self.view.frame.size.height)/2)
            
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
        
        let appDelegate:AppDelegate = AppDelegate.sharedInstance
        
        if(self.transaperantLoadingViewOnWindow == nil){
            
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
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
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
    
    //MARK: Retry view methods

    func showRetryView(message:String) {
        
        if(self.retryView == nil){

            // add custom picker view
            self.retryView = UINib(nibName: "RetryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? RetryView
            self.retryView?.frame = self.view.frame
            self.retryView?.delegate = self
            self.view.addSubview(self.retryView!)
        }
        
        self.retryView?.messageLabel.text = message
        self.view.addSubview(retryView!)
    }
    
    //MARK: Retry view delegate
    
    func retryButtonClicked() {
        
    }
    
    //MARK: Alerts
    func showQuickSuccessAlert(message:String) {
        
        let alertController:UIAlertController = UIAlertController(title: AlertMessages.success, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AlertMessages.ok, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showQuickSuccessAlert(message:String, completion:((UIAlertAction) -> Void)?) {
        
        let alertController:UIAlertController = UIAlertController(title: AlertMessages.success, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AlertMessages.ok, style: .cancel, handler: completion))
        present(alertController, animated: true, completion: nil)
    }
    
    func showQuickFailureAlert(message:String) {
        
        let alertController:UIAlertController = UIAlertController(title: AlertMessages.failure, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AlertMessages.ok, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showQuickErrorAlert(message:String) {
        
        let alertController:UIAlertController = UIAlertController(title: AlertMessages.error, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AlertMessages.ok, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showNoInternetAlert() {
        
        let alertController:UIAlertController = UIAlertController(title: AlertMessages.networkUnavailable, message: AlertMessages.connectToInternet, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AlertMessages.ok, style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Back Swipe
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    


}
