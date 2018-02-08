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
                    let responseArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as! [[String:Any]]
                    
                    let settings:Settings = Settings(JSON: responseArray[0] as [String:Any])!
                    
                    onSuccess(settings)
                }
                else
                {
                    onFailure("Unable to fetch settings data")
                }
            }
            else{
                
                onFailure("Unable to fetch setings data")
            }
        }
    }
    
    
    func setSettingOfUser(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
                
        request(URLS.setSettings, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {                    
                    onSuccess("Setting saved")
                }
                else
                {
                    onFailure("Unable to update setting")
                }
            }
            else{
                
                onFailure("Unable to update setting")
            }
        }
    }
}
