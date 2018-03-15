//
//  LoginViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {

    //MARK: Outlets and Properties
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var signInToYourAccountLabel: UILabel!
    @IBOutlet weak var emailLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var emailTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var passwordLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var passwordTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var captchaView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginWithGoogleButton: UIButton!
    
    var dataController:LoginDataController = LoginDataController()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Text Field Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
            dataController.loginType = LoginType.normal
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
    
    
    @IBAction func loginWithGoogleButtonAction(_ sender: UIButton) {
        
    }
    
    
    
    
}
