//
//  LoginViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit
import GoogleSignIn
import MessageUI

class LoginViewController: BaseViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate, GIDSignInUIDelegate {

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
    
    @IBOutlet weak var rememberMeButton: UIButton!

    @IBOutlet weak var rememberMeLabel: CustomBlueTextColorLabel!
    
    @IBOutlet weak var forgotPasswordButton: CustomBlueTextColorButton!
    
    @IBOutlet weak var helpButton: UIButton!
    
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
        setUpAutoFill()
    }
    
    func setUpAutoFill() {
        
        let savedEmail:String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.rememberedLoginEmail)
        let savedPassword:String? = UserDefaults.standard.string(forKey: UserDefaultsKeys.rememberedLoginPassword)
        emailTextField.text = savedEmail
        passwordTextField.text = savedPassword
        if savedEmail != nil {
            rememberMeButton.setImage(UIImage(named: ImageNames.checkBox), for: .normal)
            dataController.rememberUser = true
        }
        else {
            rememberMeButton.setImage(UIImage(named: ImageNames.unCheckBox), for: .normal)
            dataController.rememberUser = false
        }
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
            self.changeIdButton.backgroundColor = ColorConstants.kRedColor
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
    
    func showGoogleButton(isOKTA:Bool) {
        
        DispatchQueue.main.async {
            self.proceedButtonHeight.constant = 0
            self.signInButtonHeight.constant = 0
            self.loginWithGoogleButton.isHidden = false
            self.emailTextField.isEnabled = false
            self.emailTextField.backgroundColor = UIColor.lightGray
            self.changeIdButton.backgroundColor = ColorConstants.kBlueColor
            if isOKTA {
                self.loginWithGoogleButton.isUserInteractionEnabled = false
                self.loginWithGoogleButton.setTitle(ConstantStrings.loginWithOKTA, for: .normal)
            }
            else {
                self.loginWithGoogleButton.isUserInteractionEnabled = true
                self.loginWithGoogleButton.setTitle(ConstantStrings.loginWithGoogle, for: .normal)
            }
            
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
            self.showBackButton()
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
            if animated {
                UIView.animate(withDuration: AnimationDurations.normal, animations: {
                    self.view.layoutIfNeeded()
                })
            }
            else {
                self.passwordView.isHidden = false
                self.view.layoutIfNeeded()
            }
            self.showBackButton()
        }
    }
    
    func showBackButton() {
        self.changeIdButton.isHidden = false
        self.changeIdButtonHeight.constant = self.changeIdButtonFullHeight
        UIView.animate(withDuration: AnimationDurations.normal, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func hideBackButton(animated:Bool) {
        self.changeIdButtonHeight.constant = 0
        if animated {
            UIView.animate(withDuration: AnimationDurations.normal, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (isCompleted) in
                self.changeIdButton.isHidden = true
            })
        }
        else {
            self.view.layoutIfNeeded()
            self.changeIdButton.isHidden = true
        }
    }
    
    func hidePasswordView(animated:Bool) {
        
        if self.passwordViewHeight.constant == 0 {
            return
        }
        
        DispatchQueue.main.async {
            self.passwordViewHeight.constant = 0
            if animated {
                UIView.animate(withDuration: AnimationDurations.normal, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { (isCompleted) in
                    self.passwordView.isHidden = true
                })
            }
            else {
                self.view.layoutIfNeeded()
                self.passwordView.isHidden = true
            }
            self.hideBackButton(animated: animated)
        }
    }
    
    //MARK:Button Actions
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        
        view.endEditing(true)
        
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
                    if signInType == .normal {
                        self.showSignInButton()
                    }
                    else if signInType == .gmailSSO {
                        self.showGoogleButton(isOKTA: false)
                    }
                    else {
                        self.showGoogleButton(isOKTA: true)
                    }
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
        
        view.endEditing(true)
        
        if !Reachability.isConnectedToNetwork() {
            showNoInternetAlert()
            return
        }
        
        AppDelegate.sharedInstance.onGoogleSignInSuccess = { (googleSignInData) in
            let (email, _/*id*/, token) = googleSignInData
            self.dataController.userName = email
            self.dataController.password = ""
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
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func showHidePasswordButtonAction(_ sender: Any) {
        
        if(showPasswordToggle)
        {
            showPasswordToggle = false
            passwordTextField.isSecureTextEntry = false
            showHidePasswordButton.setImage(UIImage(named:ImageNames.showPassword), for: .normal)
        }
        else
        {
            showPasswordToggle = true
            passwordTextField.isSecureTextEntry = true
            showHidePasswordButton.setImage(UIImage(named:ImageNames.hidePassword), for: .normal)
        }
        
    }
    
    
    @IBAction func rememberMeButtonAction(_ sender: UIButton) {
        dataController.rememberUser = !dataController.rememberUser
        if dataController.rememberUser {
            DispatchQueue.main.async {
                sender.setImage(UIImage(named: ImageNames.checkBox), for: .normal)
            }
        }
        else {
            DispatchQueue.main.async {
                sender.setImage(UIImage(named: ImageNames.unCheckBox), for: .normal)
            }
        }
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: CustomBlueTextColorButton) {
        
        let forgotPasswordVC = self.storyboard!.instantiateViewController(withIdentifier: StoryboardIDs.forgotPasswordNavigationController) as! ForgotPasswordViewController
        forgotPasswordVC.prefilledEmail = emailTextField.text
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    //MARK: Help Mail
    
    @IBAction func helpButtonAction(_ sender: UIButton) {
        openMailController()
    }
    
    func openMailController() {
        
        if MFMailComposeViewController.canSendMail() {
            let mailController:MFMailComposeViewController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setToRecipients([EmailIDs.helpEmailId])
            self.present(mailController, animated: true, completion: nil)
        }
        else {
            self.showQuickErrorAlert(message: AlertMessages.cannotOpenEmail)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
