//
//  ConversationsPostObject.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationsPostObject: NSObject, Mappable {
    
    var userId:String = ""
    var userEmail:String = ""
    var userPassword:String = ""
    var postStart:String = "0"
    var postLimit:String = "0"
    var searchValue:String = ""
    var postType:String = ""
    var postTypeId:String = ""
    
    required convenience init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        userId <- map["post_sender_userid"]
        userEmail <- map["post_sender_email"]
        userPassword <- map["post_sender_password"]
        postStart <- map["post_start"]
        postLimit <- map["post_limit"]
        searchValue <- map["search_value"]
        postType <- map["post_type"]
        postTypeId <- map["post_type_id"]
    }
    
}

