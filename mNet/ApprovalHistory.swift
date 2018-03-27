//
//  ApprovalHistory.swift
//  mNet
//
//  Created by Nachiket Vaidya on 16/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalHistory: NSObject, Mappable {
    
    static let userRoleCreator:String = "CREATOR"
    
    var userId:String = ""
    var userName:String = "-"
    var profileImageLink:String = ""
    var approveType:String = ""
    var createdOn:String = "-"
    var approvalUserType:String = ""
    var approvalUserRole:String = "-"
    
    var statusImage:UIImage {
        
        if approvalUserRole.uppercased() == ApprovalHistory.userRoleCreator {
            return #imageLiteral(resourceName: "dash")
        }
        else {
            switch approveType {
            case "0": return #imageLiteral(resourceName: "questionMark")
            case "1": return #imageLiteral(resourceName: "greenTick")
            case "2": return #imageLiteral(resourceName: "redCross")
            default: return #imageLiteral(resourceName: "dash")
            }
        }
    }
    
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
