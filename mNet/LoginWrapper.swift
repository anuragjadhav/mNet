//
//  LoginWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/27/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class LoginWrapper: NSObject {
    
    
    func identifyUser(postParams:[String : Any], onSuccess:@escaping ([String:String]) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.identifyUser, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding , headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:Int = responseDict[DictionaryKeys.APIResponse.error] as! Int
                
                if(error == DictionaryKeys.APIResponse.noErrorInt)
                {
                    guard let userDictionary:[String:String] = (responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:String]])?.first else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again.")))
                        return
                    }
                    
                    onSuccess(userDictionary)
                }
                    
                else if let errorMessage:String = responseDict[DictionaryKeys.APIResponse.responseData] as? String {
                    onFailure(errorMessage)
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
            }
        }
    }
    
    func authenticateUser(postParams:[String : Any], onSuccess:@escaping (User) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.loginAuthenticate, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding , headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:Int = responseDict[DictionaryKeys.APIResponse.error] as! Int
                
                if(error == DictionaryKeys.APIResponse.noErrorInt)
                {
                    guard let userDictionary:[String:Any] = responseDict[DictionaryKeys.APIResponse.responseData] as? [String:Any] else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again.")))
                        return
                    }
                    
                    guard let mappedUser:User = User(JSON: userDictionary) else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                        return
                    }
                    onSuccess(mappedUser)
                }
                    
                else if let errorMessage:String = responseDict[DictionaryKeys.APIResponse.responseData] as? String {
                    
                    onFailure(errorMessage)
                }
                    
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
            }
        }
    }
    
    func getUserDetails(postParams:[String:Any], onSuccess:@escaping (String,String) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.getUserDetails, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                return
            }
            
            if commonResponse.noError {
                
                guard let responseDict:[String:Any] = commonResponse.responseData as? [String:Any] else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                    return
                }
                
                guard let userId:String = responseDict[DictionaryKeys.User.userId] as? String else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                    return
                }
                
                guard let userCode:String = responseDict[DictionaryKeys.User.userCode] as? String else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                    return
                }
                
                onSuccess(userId,userCode)
            }
            
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: "Login Failed. Please try again."))
                return
            }
        }
    }
    
    func registerDeviceToken(isLogout:Bool, postParams:[String : Any], onSuccess:@escaping () -> Void , onFailure : @escaping () -> Void) {
        
        var urlToHit:URL = URLS.registerDevice
        
        if isLogout {
            urlToHit = URLS.deRegisterDevice
        }
        
        request(urlToHit, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { (response) in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error = responseDict[DictionaryKeys.APIResponse.error]
                
                if (error is Int)
                {
                    if (error as! Int == DictionaryKeys.APIResponse.noErrorInt) {
                        
                        onSuccess()
                        return
                    }
                }
                else if (error  is String)
                {
                    if (error as! String == DictionaryKeys.APIResponse.noError) {
                        
                        onSuccess()
                        return
                    }
                }
                else {
                    onFailure()
                    return
                }
            }
            
            else {
                onFailure()
                return
            }
        }
    }
    
    //MARK: Forgot Password
    func postForgotPassword(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.forgotPassword, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            if commonResponse.noError {
                onSuccess()
            }
            else {
                let serverErrorMessage:String? = commonResponse.responseData as? String
                onFailure(WrapperManager.shared.getErrorMessage(message: serverErrorMessage))
                return
            }
        }
    }
}
