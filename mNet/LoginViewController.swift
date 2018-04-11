//
//  LoginViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: BaseViewController, UITextFieldDelegate {

    //MARK: Outlets and Properties
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var signInToYourAccountLabel: UILabel!
    @IBOutlet weak var emailLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var emailTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var passwordLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var passwordTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginWithGoogleButton: UIButton!
    
    @IBOutlet weak var proceedButton: CustomBlueBackgroundButton!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var proceedButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var signInButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var googleButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var changeIdButton: CustomRedBackgroundColorButton!
    
    @IBOutlet weak var changeIdButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var showHidePasswordButton: UIButton!
    
    
    var dataController:LoginDataController = LoginDataController()
    
    let passwordViewFullHeight:CGFloat = 82
    let buttonFullHeight:CGFloat = 36
    let changeIdButtonFullHeight:CGFloat = 36
    
    var showPasswordToggle:Bool = false
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    func setUpViewController() {
        
        showProceedButton(animated: false)
        hidePasswordView(animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func showProceedButton(animated:Bool) {
        
        DispatchQueue.main.async {
            
            self.signInButtonHeight.constant = 0
            self.googleButtonHeight.constant = 0
            self.changeIdButtonHeight.constant = 0
            self.emailTextField.isEnabled = true
            self.emailTextField.backgroundColor = UIColor.white
            
            if animated {
                UIView.animate(withDuration: AnimationDurations.fast, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { (isCompleted) in
                    
                    self.signInButton.isHidden = true
                    self.loginWithGoogleButton.isHidden = true
                    self.changeIdButton.isHidden = true
                    self.proceedButtonHeight.constant = self.buttonFullHeight
                    self.proceedButton.isHidden = false
                    self.hidePasswordView(animated: true)
                    UIView.animate(withDuration: AnimationDurations.normal, animations: {
                        self.view.layoutIfNeeded()
                    })
                })
            }
            else {
                self.proceedButtonHeight.constant = self.buttonFullHeight
                self.signInButton.isHidden = true
                self.loginWithGoogleButton.isHidden = true
                self.changeIdButton.isHidden = true
                self.hidePasswordView(animated: true)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showSignInButton() {
        
        DispatchQueue.main.async {
            self.proceedButtonHeight.constant = 0
            self.googleButtonHeight.constant = 0
            self.changeIdButton.isHidden = false
            self.signInButton.isHidden = false
            self.emailTextField.isEnabled = false
            self.emailTextField.backgroundColor = UIColor.lightGray
            
            UIView.animate(withDuration: AnimationDurations.fast, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (isCompleted) in
                
                self.proceedButton.isHidden = true
                self.loginWithGoogleButton.isHidden = true
                self.signInButtonHeight.constant = self.buttonFullHeight
                self.showPasswordView(animated: true)
                UIView.animate(withDuration: AnimationDurations.normal, animations: {
                    self.view.layoutIfNeeded()
                })
            })
        }
    }
    
    func showGoogleButton() {
        
        DispatchQueue.main.async {
            self.proceedButtonHeight.constant = 0
            self.signInButtonHeight.constant = 0
            self.loginWithGoogleButton.isHidden = false
            
            UIView.animate(withDuration: AnimationDurations.normal, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (isCompleted) in
                
                self.proceedButton.isHidden = true
                self.signInButton.isHidden = true
                self.googleButtonHeight.constant = self.buttonFullHeight
                UIView.animate(withDuration: AnimationDurations.normal, animations: {
                    self.view.layoutIfNeeded()
                })
            })
        }
    }

    
    func showPasswordView(animated:Bool) {
        
        if self.passwordViewHeight.constant == passwordViewFullHeight {
            return
        }
        
        self.showSignInButton()
        
        DispatchQueue.main.async {
            self.passwordViewHeight.constant = self.passwordViewFullHeight
            self.passwordView.isHidden = false
            self.changeIdButton.isHidden = false
            self.changeIdButtonHeight.constant = self.changeIdButtonFullHeight
            if animated {
                UIView.animate(withDuration: AnimationDurations.normal, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            else {
                self.passwordView.isHidden = false
                self.changeIdButton.isHidden = false
                self.changeIdButtonHeight.constant = self.changeIdButtonFullHeight
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func hidePasswordView(animated:Bool) {
        
        if self.passwordViewHeight.constant == 0 {
            return
        }
        
        DispatchQueue.main.async {
            self.passwordViewHeight.constant = 0
            self.changeIdButtonHeight.constant = 0
            if animated {
                UIView.animate(withDuration: AnimationDurations.normal, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { (isCompleted) in
                    self.passwordView.isHidden = true
                    self.changeIdButton.isHidden = true
                })
            }
            else {
                self.view.layoutIfNeeded()
                self.passwordView.isHidden = true
            }
        }
    }
    
    //MARK:Button Actions
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        
        dataController.userName = emailTextField.text ?? ""
        dataController.password = passwordTextField.text ?? ""
        
        if !Reachability.isConnectedToNetwork() {
            showNoInternetAlert()
            return
        }
        
        let validation = dataController.validateEmailAndPassword()
        
        if validation.valid {
            
            self.showTransperantLoadingOnViewController()
            dataController.loginType = LoginTypeCode.normal
            dataController.postLogin(onSuccess: { [unowned self] in
                
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        AppDelegate.sharedInstance.makeDashboardPageHome(true)
                    }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        self.showQuickFailureAlert(message: errorMessage)
                    }
            })
        }
        else {
            showQuickErrorAlert(message: validation.errorMessage)
        }
        
    }
    
    
    @IBAction func proceedButtonAction(_ sender: CustomBlueBackgroundButton) {
        
        dataController.userName = emailTextField.text ?? ""
        
        if !Reachability.isConnectedToNetwork() {
            showNoInternetAlert()
            return
        }
        
        let validation = dataController.validateEmail()
        
        if validation.isValid {
            
            self.showTransperantLoadingOnViewController()
            
            dataController.identifyUser(onSuccess: { (signInType) in
                
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.showSignInButton()
                }
                
            }, onFailure: { (errorMessage) in
                
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.showQuickErrorAlert(message: errorMessage)
                }
            })
        }
        else {
            showQuickErrorAlert(message: validation.errorMessage)
        }
    }
    
    @IBAction func changeIdButtonAction(_ sender: CustomRedBackgroundColorButton) {
        
        self.showProceedButton(animated: true)
    }
    
    
    @IBAction func loginWithGoogleButtonAction(_ sender: UIButton) {
        
        if !Reachability.isConnectedToNetwork() {
            showNoInternetAlert()
            return
        }
        
        AppDelegate.sharedInstance.onGoogleSignInSuccess = { (googleSignInData) in
            let (email, _/*id*/, token) = googleSignInData
            self.dataController.userName = email
            self.dataController.password = token
            self.showTransperantLoadingOnViewController()
            self.dataController.loginType = LoginTypeCode.googleSSO
            self.dataController.postLogin(onSuccess: { [unowned self] in
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    AppDelegate.sharedInstance.makeDashboardPageHome(true)
                }
                }, onFailure: { [unowned self] (errorMessage) in
                    DispatchQueue.main.async {
                        self.removeTransperantLoadingFromViewController()
                        self.showQuickFailureAlert(message: errorMessage)
                    }
            })
        }
        AppDelegate.sharedInstance.onGoogleSignInFailure = { (errorMessage) in
            self.showQuickErrorAlert(message: errorMessage)
            GIDSignIn.sharedInstance().signOut()
        }
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func showHidePasswordButtonAction(_ sender: Any) {
        
        if(showPasswordToggle)
        {
            showPasswordToggle = false
            passwordTextField.isSecureTextEntry = false
            showHidePasswordButton.setImage(UIImage(named:"hidePassword"), for: .normal)
        }
        else
        {
            showPasswordToggle = true
            passwordTextField.isSecureTextEntry = true
            showHidePasswordButton.setImage(UIImage(named:"showPassword"), for: .normal)
        }
        
    }
    
   
}
