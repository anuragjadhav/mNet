//
//  Notification.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/30/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationObject: NSObject,Mappable {
    
    var notificationId: String?
    var recieverUserId: String?
    var notificationDesc: String?
    var notificationLink:String?
    var notificationType: String?
    var postId: String?
    var notificationTypeId:String?
    var status:String?
    var createdBy:String?
    var createdOn:String?
    var userId:String?
    var username:String?
    var profileImgLink:String?
    var userFirstName:String?
    var userLastName:String?
    var isApproval:String?
    var approvalType:String?
    var postTitle:String?
    var stringLabel2Value:String?
    var postSenderId:String?
    var sender: String?
    var notificationMessage:String?
    var replyPostName:String?
    var postTypeName:String?
    var replyCount:String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
        notificationId                  <- map["notification_id"]
        recieverUserId                <- map["reciever_user_id"]
        notificationDesc                 <- map["notification_desc"]
        notificationLink                    <- map["notification_link"]
        notificationType            <- map["notification_type"]
        postId             <- map["post_id"]
        notificationTypeId                    <- map["notification_type_Id"]
        status                <- map["status"]
        createdBy                   <- map["created_by"]
        createdOn                  <- map["created_on"]
        userId                   <- map["user_id"]
        username               <- map["username"]
        profileImgLink     <- map["profile_img_link"]
        userFirstName    <- map["user_first_name"]
        userLastName    <- map["user_last_name"]
        isApproval    <- map["is_approval"]
        approvalType    <- map["approval_type"]
        postTitle    <- map["post_title"]
        stringLabel2Value    <- map["string_label2_value"]
        postSenderId    <- map["post_sender_id"]
        sender    <- map["sender"]
        notificationMessage    <- map["notification_message"]
        replyPostName    <- map["reply_post_name"]
        postTypeName    <- map["post_type_name"]
        replyCount    <- map["reply_count"]
    }
}
