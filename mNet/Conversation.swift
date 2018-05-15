//
//  Conversation.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class Conversation: NSObject, Mappable {

    var postId:String = ""
    var senderName:String = ""
    var senderImage:String?
    var postTitle:String = ""
    var postMessage:String = ""
    var postLink:String = ""
    var postClient:String = ""
    var postComments:[String] = []
    var postModifiedOn:String = ""
    var postCreator:String = ""
    var postEmailNotification:String = ""
    var replyEmailNotification:String = ""
    var readState:String = ""
    var createdOn:String = ""
    var latestReplierName:String = ""
    var latesReplierImage:String?
    var latestReplierMessage:String = ""
    var latestReplierDate:String = ""
    var postType:String = ""
    var postTypeId:String = ""
    var approvalType:String = ""
    var membersList:[ConversationMember] = []
    var reply:[ConversationReply] = []
    var latestReplierDesignation:String = ""
    var ignore:String = "0"
    var postTypeValue:String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        postId <- map["post_id"]
        senderName <- map["post_sender_name"]
        senderImage <- map["post_sender_profile_img_link"]
        postTitle <- map["post_title"]
        postMessage <- map["post_message"]
        postLink <- map["post_link"]
        postClient <- map["post_client"]
        postComments <- map["post_comments"]
        postModifiedOn <- map["modified_on"]
        postCreator <- map["post_creator"]
        postEmailNotification <- map["post_email_notification"]
        replyEmailNotification <- map["reply_email_notification"]
        readState <- map["read_state"]
        createdOn <- map["created_on"]
        latestReplierName <- map["latest_replyer_name"]
        latesReplierImage <- map["latest_replyer_image"]
        latestReplierMessage <- map["latest_replyer_message"]
        latestReplierDate <- map["latest_replyer_date"]
        membersList <- map["memberlist"]
        reply <- map["reply"]
        postType <- map["post_type"]
        postTypeId <- map["post_type_id"]
        approvalType <- map["approval_type"]
        latestReplierDesignation <- map["latest_replyer_desingnation"]
        ignore <- map["ignore_status"]
        postTypeValue <- map["post_type_value"]
    }
}
