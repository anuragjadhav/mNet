//
//  PeopleWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/31/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PeopleWrapper: NSObject {
    
    func getPeopleList(postParams:[String:Any], onSuccess:@escaping ([People]) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getPeopleList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let peopleDictArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:Any]] else {
                        onSuccess([People]())
                        return
                    }
                    let peopleArray:[People] = [People].init(JSONArray: peopleDictArray)
                    onSuccess(peopleArray)
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch people list"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch people list"))
            }
        }
    }
    
    func getPeopleProfile(postParams:[String:Any], onSuccess:@escaping (Profile) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getPeopleProfile, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let peopleProfileArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:Any]] else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch profile details"))
                        return
                    }
                    let profile:Profile = Profile.init(JSON:peopleProfileArray[0])!
                    onSuccess(profile)
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch profile details"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch profile details"))
            }
        }
    }
    
    func blockUser(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.blockUnblock, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message:nil))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message:nil))
            }
        }
    }
}
