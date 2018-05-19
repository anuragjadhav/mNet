//
//  ForgotPasswordDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 05/05/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ForgotPasswordDataController: NSObject {

    var emailID:String = ""
    var otp:String = ""
    var password:String = ""
    var confirmPassword:String = ""
    
    func sendForgotPasswordEmail(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        var postDictionary:[String:String] = [String:String]()
        postDictionary[DictionaryKeys.IdentifyUser.userEmail] = emailID
        postDictionary[DictionaryKeys.IdentifyUser.requestFrom] = DictionaryKeys.IdentifyUser.requesrFromMobileApp
        postDictionary[DictionaryKeys.IdentifyUser.platform] = DictionaryKeys.IdentifyUser.platformIOS
        postDictionary[DictionaryKeys.ForgotPassword.action] = DictionaryKeys.ForgotPassword.actionSendOTP
        postDictionary[DictionaryKeys.ForgotPassword.otp] = ""
        WrapperManager.shared.loginWrapper.postForgotPassword(postParams: postDictionary, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func sendOTPForVerification(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        var postDictionary:[String:String] = [String:String]()
        postDictionary[DictionaryKeys.IdentifyUser.userEmail] = emailID
        postDictionary[DictionaryKeys.IdentifyUser.requestFrom] = DictionaryKeys.IdentifyUser.requesrFromMobileApp
        postDictionary[DictionaryKeys.IdentifyUser.platform] = DictionaryKeys.IdentifyUser.platformIOS
        postDictionary[DictionaryKeys.ForgotPassword.action] = DictionaryKeys.ForgotPassword.actionValidateOTP
        postDictionary[DictionaryKeys.ForgotPassword.otp] = otp
        WrapperManager.shared.loginWrapper.postForgotPassword(postParams: postDictionary, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func sendNewPassword(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        var postDictionary:[String:String] = [String:String]()
        postDictionary[DictionaryKeys.IdentifyUser.userEmail] = emailID
        postDictionary[DictionaryKeys.IdentifyUser.requestFrom] = DictionaryKeys.IdentifyUser.requesrFromMobileApp
        postDictionary[DictionaryKeys.IdentifyUser.platform] = DictionaryKeys.IdentifyUser.platformIOS
        postDictionary[DictionaryKeys.ForgotPassword.action] = DictionaryKeys.ForgotPassword.actionSetPassword
        postDictionary[DictionaryKeys.ForgotPassword.otp] = otp
        postDictionary[DictionaryKeys.ForgotPassword.newPassword] = password
        WrapperManager.shared.loginWrapper.postForgotPassword(postParams: postDictionary, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func validateEmail() -> (isValid:Bool, errorMessage:String) {
        
        if emailID.isEmpty {
            return (false,"Please enter Email-ID")
        }
        
        if !emailID.isValidEmail() {
            return (false,"Please enter a valid Email-ID")
        }
        
        return (true,"")
    }
    
    func validatePasswords() -> (isValid:Bool, errorMessage:String) {
        
        if password.isEmpty {
            return (false,"Please enter your new password")
        }
        
        if confirmPassword.isEmpty {
            return (false,"Please re-enter your new password")
        }
        
        if password != confirmPassword {
            return (false,"Passwords do not match")
        }
        
        return (true,"")
    }
    
}
