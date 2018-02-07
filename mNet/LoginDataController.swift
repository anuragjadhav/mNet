//
//  LoginDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 07/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class LoginDataController: NSObject {

    var userName:String = ""
    var password:String = ""
    var loginType:String = LoginType.normal
    
    func validateEmailAndPassword() -> (valid:Bool, errorMessage:String) {
    
        if userName.isEmpty {
            return (false,"Please enter Email-ID")
        }
        
        if !userName.isValidEmail() {
            return (false,"Please enter a valid Email-ID")
        }
        
        if password.isEmpty {
            return (false,"Please enter Password")
        }
        
        return (true,"")
    }
    
    func postLogin(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        var loginParams:[String:String] = [String:String]()
        loginParams[DictionaryKeys.LoginPost.username] = userName
        loginParams[DictionaryKeys.LoginPost.password] = password
        loginParams[DictionaryKeys.LoginPost.loginType] = loginType
        loginParams[DictionaryKeys.LoginPost.requestFrom] = DictionaryKeys.LoginPost.requestFromApp
        
        WrapperManager.shared.loginWrapper.authenticateUser(postParams: loginParams, onSuccess: { (userObject) in
            
            if userObject.userId.isEmpty {
                onFailure("Something went wrong. Please try again.")
                return
            }
            else {
                userObject.saveToUserDefaults()
                onSuccess()
            }
            
            onSuccess()
        }, onFailure: onFailure)
    }
    
}
