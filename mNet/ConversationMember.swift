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
    var profileImage:URL?
    var memberType:String = ""
    var userName:String = ""
    var userId:String = ""
    var askForAgree:String = ""
    var askForApprove:String = ""
    var approveStatus:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        memberReadState     <- map["member_read_state"]
        profileImage        <- (map["profileImage"],URLTransform())
        memberType          <- map["memberType"]
        userName            <- map["userName"]
        userId              <- map["userId"]
        askForAgree         <- map["askForAgree"]
        askForApprove       <- map["askForApprove"]
        approveStatus       <- map["approveStatus"]
    }
}
