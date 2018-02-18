//
//  Approval.swift
//  mNet
//
//  Created by Nachiket Vaidya on 15/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class Approval: NSObject, Mappable {
    
    var postId:String = ""
    var postType:String = ""
    var postTypeId:String = ""
    var postSenderId:String = ""
    var postTitle:String = ""
    var postMessage:String = ""
    var postStatus:String = ""
    var postClient:String = ""
    var postLink:String = ""
    var modifiedOn:String = ""
    var modifiedBy:String = ""
    var createdOn:String = ""
    var createdBy:String = ""
    var approvalType:String = ""
    var title1:String = ""
    var documentDetailsScreenName:String = ""
    var brand:String = ""
    var period:String = ""
    var title1Note3:String = ""
    var documentDetailsTab1Name:String = ""
    var documentDescription:String = ""
    var remarks:String = ""
    var costCentre:String = ""
    var approveId:String = ""
    var userId:String = ""
    var postApproveType:String = ""
    var approvalUserType:String = ""
    var postOwner:String = ""
    var isDocCancel:String = ""
    var senderName:String = ""
    var senderProfileImage:String = ""
    var fileLink:String = ""
    var history:[ApprovalHistory] = [ApprovalHistory]()
    var approvalLevelLimit:String = ""
    var readState:String = ""
    var otherDocument:[String] = [String]()
    var historyCount:Int = 0
    var dynamicData:[DynamicData] = [DynamicData]()
    
    var documentType:DynamicData? {
        return dynamicData[safe:0]
    }
    
    var documentNumber:DynamicData? {
        return dynamicData[safe:1]
    }
    
    var vendor:DynamicData? {
        return dynamicData[safe:2]
    }
    
    var medium:DynamicData? {
        return dynamicData[safe:3]
    }
    
    var documentAmount:DynamicData? {
        return dynamicData[safe:4]
    }
    
    var documentDate:DynamicData? {
        return dynamicData[safe:5]
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        postId                      <- map["post_id"]
        postType                    <- map["post_type"]
        postTypeId                  <- map["post_type_id"]
        postSenderId                <- map["post_sender_id"]
        postTitle                   <- map["post_title"]
        postMessage                 <- map["post_message"]
        postStatus                  <- map["post_status"]
        postClient                  <- map["post_client"]
        postLink                    <- map["post_link"]
        modifiedOn                  <- map["modified_on"]
        modifiedBy                  <- map["modified_by"]
        createdOn                   <- map["created_on"]
        createdBy                   <- map["created_by"]
        approvalType                <- map["approval_type"]
        documentDetailsScreenName   <- map["title1"]
        brand                       <- map["title1_note_1"]
        period                      <- map["title1_note_2"]
        title1Note3                 <- map["title1_note_3"]
        documentDetailsTab1Name     <- map["title2"]
        documentDescription         <- map["title2_note_1"]
        remarks                     <- map["title2_note_2"]
        costCentre                  <- map["title2_note_3"]
        approveId                   <- map["approve_id"]
        userId                      <- map["user_id"]
        postApproveType             <- map["post_approve_type"]
        approvalUserType            <- map["approval_user_type"]
        postOwner                   <- map["post_owner"]
        isDocCancel                 <- map["is_doc_cancel"]
        senderName                  <- map["sender_name"]
        senderProfileImage          <- map["sender_profile_image"]
        fileLink                    <- map["file_link"]
        history                     <- map["history"]
        approvalLevelLimit          <- map["approval_level_limit"]
        readState                   <- map["read_state"]
        otherDocument               <- map["other_document"]
        historyCount                <- map["historycount"]
        dynamicData                 <- map["dynamic"]
    }
}
