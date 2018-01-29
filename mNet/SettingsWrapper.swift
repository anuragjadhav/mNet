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
        
        let postParams:[String:Any] = postObject.toJSON()
        
        request(URLS.getSettings, method: .get, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response: DataResponse<Settings>) in
            
            if let setting:Settings = response.result.value {
                
                onSuccess(setting)
            }
            else{
                
                onFailure("Unable to fetch privacy settings data")
            }
        }
    }
    
    
    func setSettingOfUser(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
                
        request(URLS.setSettings, method: .put, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseString { response in
            
            let statusCode:Int = (response.response?.statusCode)!
            
            if statusCode == 200 || statusCode == 201 {
                
                onSuccess("Setting updated")
            }
            else{
                
                onFailure("Unable to update setting")
            }
        }
    }
}
