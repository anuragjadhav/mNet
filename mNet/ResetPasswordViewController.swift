//
//  ResetPasswordViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 3/15/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ResetPasswordViewController: BaseViewController,UITextFieldDelegate {

    @IBOutlet weak var newPasswordTextfield: CustomBrownTextColorTextfield!
    @IBOutlet weak var confirmPasswordTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var oldPasswordTextField: CustomBrownTextColorTextfield!
    var dataCtrl:SettingsProfileDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Text Field Delegates
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }


    // MARK: - Button Actions

    @IBAction func resetPasswordButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if(oldPasswordTextField.text != nil && oldPasswordTextField.text != "" && newPasswordTextfield.text != nil && confirmPasswordTextField.text != nil && newPasswordTextfield.text != "" && confirmPasswordTextField.text != "" && newPasswordTextfield.text == confirmPasswordTextField.text)
        {
            if Reachability.isConnectedToNetwork(){
                
                self.showTransperantLoadingOnWindow()
                dataCtrl?.resetNewPassword(oldPassword:oldPasswordTextField.text!,newPassword: newPasswordTextfield.text!,onSuccess: { [unowned self]  in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromWindow()
                        
                        let alert = UIAlertController(title:AlertMessages.success, message:"Password reset successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                            
                             User.logoutUser()
                             AppDelegate.sharedInstance.makeLoginPageHome(true)
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    }, onFailure: { [unowned self] (errorMessage) in
                        
                        DispatchQueue.main.async {
                            
                            self.removeTransperantLoadingFromWindow()
                            
                            let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                })
                
            }else{
                
                let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            
          if(oldPasswordTextField.text == nil || oldPasswordTextField.text == "" || newPasswordTextfield.text == nil || newPasswordTextfield.text == "")
          {
                let alert = UIAlertController(title:AlertMessages.sorry, message:"Please enter old and new password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
          }
          else
          {
            let alert = UIAlertController(title:AlertMessages.sorry, message:"New passowrd and confirm password doesnot match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
          }
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
