//
//  ConversationMember.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationMember: NSObject, Mappable {
    
    var memberReadState:String = ""
    var profileImage:String?
    var memberType:String = ""
    var userName:String = ""
    var userId:String = ""
    var askForAgree:String = ""
    var askForApprove:String = ""
    var approveStatus:String = ""
    var agreeStatus:String = ""
    
    var order:Int {
        
        if(memberType.lowercased() == "creator" || memberType.lowercased() == "owner")
        {
            return 0
        }
        else if(memberType.lowercased() == "to")
        {
            return 1
        }
        else if(memberType.lowercased() == "cc")
        {
            return 2
        }
        else if(memberType.lowercased() == "bcc")
        {
            return 3
        }
        else
        {
            return 4
        }
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        memberReadState     <- map["member_read_state"]
        profileImage        <- map["profile_img_link"]
        memberType          <- map["member_type"]
        userName            <- map["user_name"]
        userId              <- map["user_id"]
        askForAgree         <- map["ask_for_agree"]
        askForApprove       <- map["ask_for_approve"]
        approveStatus       <- map["approve_status"]
        agreeStatus       <- map["agree_status"]
    }
}
