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
        
        let postParams:[String:Any] = postObject.toJSON()
        
        request(URLS.getProfile, method: .get, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response: DataResponse<Profile>) in
            
            if let profile:Profile = response.result.value {
                
                onSuccess(profile)
            }
            else{
                
                onFailure("Unable to fetch profile data")
            }
        }
    }
    
    func updateUserProfileWithParams(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.updateProfile, method: .put, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseString { response in
            
            let statusCode:Int = (response.response?.statusCode)!
            
            if statusCode == 200 || statusCode == 201 {
                
                onSuccess("Profile Updated")
            }
            else{
                
                onFailure("Unable to update profile data")
            }
        }
    }

}
