//
//  ForgotPasswordViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 05/05/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var emailTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var sendOTPButton: CustomBlueBackgroundButton!
    
    var dataController:ForgotPasswordDataController = ForgotPasswordDataController()
    
    var prefilledEmail:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(prefilledEmail != nil)
        {
            emailTextField.text = prefilledEmail
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //emailTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendOTPButtonAction(_ sender: CustomBlueBackgroundButton) {
        
        dataController.emailID = emailTextField.text ?? ""
        let validation = dataController.validateEmail()
        
        if validation.isValid {
            self.showTransperantLoadingOnViewController()
            dataController.sendForgotPasswordEmail(onSuccess: {
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.showQuickSuccessAlert(message: AlertMessages.otpSent, completion: { (alertAction) in
                        self.performSegue(withIdentifier: SegueIdentifiers.forgotPasswordToOTP, sender: self)
                    })
                }
            }) { (errorMessage) in
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.showQuickFailureAlert(message: errorMessage)
                }
            }
        }
        else {
            self.showQuickErrorAlert(message: validation.errorMessage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let otpViewController:OTPViewController = segue.destination as! OTPViewController
        otpViewController.dataController = dataController
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: Navigation Buttons
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        cancelForgotPassword()
    }
    
    
    func cancelForgotPassword() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
