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

    func getNotifcations(isReload:Bool,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        if(isReload){
            
            start = 0
            notifications.removeAll()
        }
        
        let user:User = User.loggedInUser()!
        
        var postParams:[String:Any] = user.toJSON()
        postParams["limit"] = "\(limit)"
        postParams["start"] = "\(start)"

        WrapperManager.shared.notifiactionWrapper.getNotificationList(postParams: postParams, onSuccess: { [unowned self] (notificationArray) in
            
            for notification in notificationArray
            {
                self.notifications.append(notification)
            }
            
            //change start
            self.start += self.notifications.count
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
}
