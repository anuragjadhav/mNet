//
//  NotificationWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/30/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationWrapper: NSObject {
    
    func getNotificationList(postParams:[String:Any], onSuccess:@escaping ([NotificationObject]) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getNotificationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    let notificationDictArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as! [[String:Any]]
                    let notificationsArray:[NotificationObject] = [NotificationObject].init(JSONArray: notificationDictArray)
                    onSuccess(notificationsArray)
                }
                else
                {
                    onFailure("Unable to fetch notifications")
                }
            }
            else{
                
                onFailure("Unable to fetch notifications")
            }
        }
    }
    
    
    func markNotificationAsRead(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping () -> Void){
        
        request(URLS.markNotificationAsRead, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict["error"] as! String
                
                if(error == "0")
                {
                    onSuccess()
                }
                else
                {
                    onFailure()
                }
            }
            else{
                
                onFailure()
            }
        }
    }
}
