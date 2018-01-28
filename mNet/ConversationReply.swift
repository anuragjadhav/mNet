//
//  ConversationReply.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationReply: NSObject, Mappable {

    var replyId:String = ""
    var userId:String = ""
    var profileImage:URL?
    var replyMessage:String = ""
    var fullName:String = ""
    var replyStatus:String = ""
    var replyType:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        replyId         <- map["reply_id"]
        userId          <- map["user_id"]
        profileImage    <- (map["profile_img_link"],URLTransform())
        replyMessage    <- map["reply_message"]
        fullName        <- map["full_name"]
        replyStatus     <- map["reply_status"]
        replyType       <- map["reply_type"]
    }
}
