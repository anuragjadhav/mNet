//
//  ApprovalHistory.swift
//  mNet
//
//  Created by Nachiket Vaidya on 16/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalHistory: NSObject, Mappable {
    
    var userId:String = ""
    var userName:String = "-"
    var profileImageLink:String = ""
    var approveType:String = ""
    var createdOn:String = "-"
    var approvalUserType:String = ""
    var approvalUserRole:String = "-"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        userId              <- map["user_id"]
        userName            <- map["username"]
        profileImageLink    <- map["profile_img_link"]
        approveType         <- map["approve_type"]
        createdOn           <- map["created_on"]
        approvalUserType    <- map["approval_user_type"]
        approvalUserRole    <- map["approval_user_role"]
    }
}
