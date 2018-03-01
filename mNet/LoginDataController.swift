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
        
        WrapperManager.shared.loginWrapper.authenticateUser(postParams: loginParams, onSuccess: { [unowned self] (userObject) in
            
            if userObject.userId.isEmpty {
                onFailure("Something went wrong. Please try again.")
                return
            }
            else {
                userObject.saveToUserDefaults()
                self.getUserDetails(onSuccess: onSuccess, onFailure: onFailure)
            }
        }, onFailure: onFailure)
    }

    func getUserDetails(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let postDictionary:[String:Any] = User.loggedInUser()!.toJSONPostWithoutId()
        
        WrapperManager.shared.loginWrapper.getUserDetails(postParams: postDictionary, onSuccess: { (newUserId) in
            
            let updatedUser:User = User.loggedInUser()!
            updatedUser.userId = newUserId
            updatedUser.saveToUserDefaults()
            onSuccess()
            self.registerDeviceToken(updatedUser)
            
        }, onFailure: onFailure)
    }
    
    func registerDeviceToken(_ user:User) {
        
        var postParams:[String:Any] = user.toJSONPostWithoutEmail()
        
        guard let deviceToken:String = UserDefaults.standard.string(forKey: UserDefaultsKeys.deviceToken) else {
            return
        }
        
        postParams[DictionaryKeys.DeviceRegistration.deviceToken] = deviceToken
        
        WrapperManager.shared.loginWrapper.registerDeviceToken(isLogout: false, postParams:postParams, onSuccess: {
            print("Device Registration Success")
        }) {
            print("Device Registration Failed")
        }
    }
}
