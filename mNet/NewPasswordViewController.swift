//
//  NewPasswordViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 05/05/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NewPasswordViewController: BaseViewController {

    @IBOutlet weak var newPasswordTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var confirmPasswordTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var resetPasswordButton: CustomBlueBackgroundButton!
    
    var dataController:ForgotPasswordDataController = ForgotPasswordDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func resetPasswordButtonAction(_ sender: CustomBlueBackgroundButton) {
        
        dataController.password = newPasswordTextField.text ?? ""
        dataController.confirmPassword = confirmPasswordTextField.text ?? ""
        let validation = dataController.validatePasswords()
        if validation.isValid {
            self.showTransperantLoadingOnViewController()
            dataController.sendNewPassword(onSuccess: {
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    self.showQuickSuccessAlert(message: AlertMessages.passwordResetSuccess, completion: { (alertAction) in
                        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.rememberedLoginEmail)
                        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.rememberedLoginPassword)
                        self.cancelForgotPassword()
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
