//
//  PrivacySettings.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit


class PrivacySettings: Mappable {
    
    var show_email : Int?
    var show_address : Int?
    var show_mobile : Int?
    var show_dob : Int?
    var show_designation :Int?
    var show_department : Int?
    var show_org : Int?
    var show_company :Int?
    var show_apps : Int?
    var show_group : Int?
    var show_task : Int?
    var show_schedule : Int?
    var post_email_notification : Int?
    var reply_email_notification : Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
      
        show_email                  <- map["show_email"]
        show_address                <- map["show_address"]
        show_mobile                 <- map["show_mobile"]
        show_dob                    <- map["show_dob"]
        show_designation            <- map["show_designation"]
        show_department             <- map["show_department"]
        show_org                    <- map["show_org"]
        show_company                <- map["show_company"]
        show_apps                   <- map["show_apps"]
        show_group                  <- map["show_group"]
        show_task                   <- map["show_task"]
        show_schedule               <- map["show_schedule"]
        post_email_notification     <- map["post_email_notification"]
        reply_email_notification    <- map["reply_email_notification"]
    }

}
