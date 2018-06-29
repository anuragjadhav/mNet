//
//  NotificationWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/30/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationWrapper: NSObject {
    
    func getNotificationList(postParams:[String:Any], onSuccess:@escaping ([NotificationObject],String) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getNotificationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let notificationDictArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:Any]] else {
                        let unreadNotifiactionCount = responseDict["unread_noti_count"] ?? "0"
                        onSuccess([NotificationObject](),unreadNotifiactionCount as! String)
                        return
                        }
                    let notificationsArray:[NotificationObject] = [NotificationObject].init(JSONArray: notificationDictArray)
                    let unreadNotifiactionCount = responseDict["unread_noti_count"] ?? "0"
                    onSuccess(notificationsArray,unreadNotifiactionCount as! String)
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch notifications"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch notifications"))
            }
        }
    }
    
    
    func markNotificationAsRead(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping () -> Void){
        
        request(URLS.markNotificationAsRead, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
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
