//
//  ApprovalUser.swift
//  mNet
//
//  Created by Nachiket Vaidya on 25/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalUser: NSObject, Mappable {

    var userId:String = ""
    var name:String = "-"
    var profileImageLink:String = ""
    var designation:String = "-"
    var postApproveType:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        userId              <- map["user_id"]
        name                <- map["username"]
        profileImageLink    <- map["profile_img_link"]
        designation         <- map["user_designation"]
        postApproveType     <- map["post_approve_type"]
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        guard let objectToCompare:ApprovalUser = object as? ApprovalUser else {
            return false
        }
        return objectToCompare.userId == self.userId
    }
    
}
