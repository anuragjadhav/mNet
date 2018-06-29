//
//  ProfileWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/28/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ProfileWrapper: NSObject {
    
    func getProfileOfUser(postObject:User, onSuccess:@escaping (Profile) -> Void , onFailure : @escaping (String) -> Void){
        
        let postParams:[String:Any] = postObject.toJSONPost()
        
        request(URLS.getProfile, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let profile:Profile = Profile(JSON: (responseDict[DictionaryKeys.APIResponse.responseData] as? [String:Any])!) else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch profile data"))
                        return
                    }
                    onSuccess(profile)
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch profile data"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch profile data"))
            }
        }
    }
    
    func updateUserProfileWithParams(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.updateProfile, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON{ response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess("Profile updated")
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure("Unable to update profile data")
                }
            }
            else{
                
                onFailure("Unable to update profile data")
            }
        }
    }

}
