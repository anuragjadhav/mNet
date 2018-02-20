//
//  NotificationDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/30/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationDataController: NSObject {
    
    var notifications:[NotificationObject] = []
    let limit:Int = 10
    var start:Int = 0

    func getNotifcations(isReload:Bool,onSuccess:@escaping (Int) -> Void , onFailure : @escaping (String) -> Void) {
        
        if(isReload){
            
            start = 0
        }
        
        let user:User = User.loggedInUser()!
        
        var postParams:[String:Any] = user.toJSONPost()
        postParams["limit"] = "\(limit)"
        postParams["start"] = "\(start)"

        WrapperManager.shared.notifiactionWrapper.getNotificationList(postParams: postParams, onSuccess: { [unowned self] (notificationArray) in
            
            if(isReload)
            {
                self.notifications = notificationArray
            }
            else
            {
                for notification in notificationArray
                {
                    self.notifications.append(notification)
                }
            }
            
            //change start
            self.start += self.notifications.count
            
            onSuccess(self.getUnreadNotificationCount())
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func getUnreadNotificationCount() -> Int
    {
        let filteredArray:[NotificationObject] =  self.notifications.filter{$0.status == "0" }
        return filteredArray.count
    }
}
