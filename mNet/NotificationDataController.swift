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
    var selectedNotification:NotificationObject?
    var unreadNotificationCount:String? = "0"
    var previousCallSuccessOrFailed:Bool = false
    let limit:Int = 10
    var start:Int = 0

    func getNotifcations(isReload:Bool,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        previousCallSuccessOrFailed = false
        
        if(isReload){
            
            start = 0
        }
        
        let user:User = User.loggedInUser()!
        
        var postParams:[String:Any] = user.toJSONPost()
        postParams["limit"] = "\(limit)"
        postParams["start"] = "\(start)"

        WrapperManager.shared.notifiactionWrapper.getNotificationList(postParams: postParams, onSuccess: { [unowned self] (notificationArray,unreadNotificationCount) in
            
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
            
            self.unreadNotificationCount = unreadNotificationCount
            self.previousCallSuccessOrFailed = true
            onSuccess()
            
        }) {[unowned self] (errorMessage) in
            self.previousCallSuccessOrFailed = true
            onFailure(errorMessage)
        }
    }
    
    
    func markNotificationAsRead() {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["UserId"] = user.userId
        postParams["UserPass"] = user.password
        postParams["UserEmail"] = user.email
        postParams["notification_id"] = selectedNotification?.notificationId
        
        WrapperManager.shared.notifiactionWrapper.markNotificationAsRead(postParams: postParams, onSuccess: { [unowned self] in
            
            self.selectedNotification?.status = "1"
        }) {
            
        }
    }
}
