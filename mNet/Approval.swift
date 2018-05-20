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
    var title1Note3:String = "-"
    var documentDetailsTab1Name:String?
    var documentDescription:String = "-"
    var remarks:String = "-"
    var costCentre:String = "-"
    var approveId:String = ""
    var userId:String = ""
    var postApproveType:String = ""
    var approvalUserType:String = "A"
    var postOwner:String = ""
    var postPriority:String = ""
    var isDocCancel:String = ""
    var senderName:String = ""
    var senderProfileImage:String = ""
    var fileLink:String = ""
    var history:[ApprovalHistory] = [ApprovalHistory]()
    var approvalLevelLimit:String = ""
    var readState:String = ""
    var otherDocument:[ApprovalDocument] = [ApprovalDocument]()
    var historyCount:Int = 0
    var dynamicData:[DynamicData] = [DynamicData]()
    var approvalUserList:[ApprovalUser] = [ApprovalUser]()
    var verificationUserList:[ApprovalUser] = [ApprovalUser]()
    var approveVerifyStatus:String = "0"
    var documentTypeTitle:String = "Document Type"
    var documentTypeValue:String = "-"
    var documentNumberTitle:String = "Document Number"
    var documentNumberValue:String = "-"
    var vendorTitle:String = "Vendor"
    var vendorValue:String = "-"
    var mediumTitle:String = "Medium"
    var mediumValue:String = "-"
    var documentAmountTitle:String = "Document Amount"
    var documentAmountValue:String = "-"
    var documentDateTitle:String = "Document Date"
    var documentDateValue:String = "-"
    
    var isActionTaken:Bool {
        return ( (approveVerifyStatus == "1") || (approveVerifyStatus == "2") || (isDocCancel == "1") )
    }
    
    var approvalStatus:ApprovalStatus {
        if isActionTaken {
            return .none
        }
        if approvalUserType == "I" {
            return .verify
        }
        return .approve
    }
    
    var selectedUsers:[ApprovalUser] = [ApprovalUser]()
    
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
        approvalUserList            <- map["post_next_user_approval"]
        verificationUserList        <- map["post_next_user_verifier"]
        postPriority                <- map["post_priority"]
        approveVerifyStatus         <- map["approve_verify_status"]
        documentTypeTitle           <- map["string_type_label1_title"]
        documentTypeValue           <- map["string_type_label1_value"]
        documentNumberTitle         <- map["string_label2_title"]
        documentNumberValue         <- map["string_label2_value"]
        vendorTitle                 <- map["string_label3_title"]
        vendorValue                 <- map["string_label3_value"]
        mediumTitle                 <- map["string_label4_title"]
        mediumValue                 <- map["string_label4_value"]
        documentAmountTitle         <- map["string_amount_label5_title"]
        documentAmountValue         <- map["string_amount_label5_value"]
        documentDateTitle           <- map["string_date_label6_title"]
        documentDateValue           <- map["date_label6_value"]
    }
}
