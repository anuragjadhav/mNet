//
//  OTPViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 05/05/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class OTPViewController: BaseViewController {

    @IBOutlet weak var otpTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var confirmButton: CustomBlueBackgroundButton!
    
    var dataController:ForgotPasswordDataController = ForgotPasswordDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //otpTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButtonAction(_ sender: CustomBlueBackgroundButton) {
        
        if otpTextField.text == nil || otpTextField.text!.isEmpty {
            self.showQuickErrorAlert(message: "Please enter OTP")
        }
        else {
            dataController.otp = otpTextField.text!
            self.showTransperantLoadingOnViewController()
            dataController.sendOTPForVerification(onSuccess: {
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.performSegue(withIdentifier: SegueIdentifiers.otpScreenToNewPassword, sender: self)
                }
            }) { (errorMessage) in
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.showQuickFailureAlert(message: errorMessage)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let newPAsswordViewController:NewPasswordViewController = segue.destination as! NewPasswordViewController
        newPAsswordViewController.dataController = dataController
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
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
