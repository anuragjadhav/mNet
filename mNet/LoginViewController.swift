//
//  LoginViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

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

    //MARK: Setup
    func setUpViewController() {
        
    }
    
    //MARK:Button Actions
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func loginWithGoogleButtonAction(_ sender: UIButton) {
    }
    
    
    
    
}
