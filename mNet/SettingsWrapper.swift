//
//  SettingsWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit


class SettingsWrapper: NSObject {
        
    func getSettingOfUser(postObject:User, onSuccess:@escaping (Settings) -> Void , onFailure : @escaping (String) -> Void){
        
        let postParams:[String:Any] = postObject.toJSONPost()
        
        request(URLS.getSettings, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let responseArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:Any]] else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch setings data"))
                        return
                    }
                    
                    let settings:Settings = Settings(JSON: responseArray[0] as [String:Any])!
                    
                    onSuccess(settings)
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                 {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                 }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch setings data"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch setings data"))
            }
        }
    }
    

    func setPrivacySettingOfUser(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
                
        request(URLS.setSettings, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {                    
                    onSuccess("Setting saved")
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to update setting"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to update setting"))
            }
        }
    }
    
    
    func setEmailPreferenceSettingOfUser(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.setEmailPreferenceSettings, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess("Setting saved")
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to update setting"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to update setting"))
            }
        }
    }
    
    func resetNewPassword(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.resetNewPassword, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:Int = responseDict[DictionaryKeys.APIResponse.error] as! Int
                
                if(error == DictionaryKeys.APIResponse.noErrorInt)
                {
                    onSuccess()
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to reset password"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to reset password"))
            }
        }
    }
}
