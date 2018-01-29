//
//  PrivacySettings.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit


class Settings:NSObject, Mappable {
    
    var showEmail : Int?
    var showAddress : Int?
    var showMobile : Int?
    var showDob : Int?
    var showDesignation :Int?
    var showDepartment : Int?
    var showOrg : Int?
    var showCompany :Int?
    var showApps : Int?
    var showGroup : Int?
    var showTask : Int?
    var showSchedule : Int?
    var postEmailNotification : Int?
    var replyEmailNotification : Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
      
        showEmail                  <- map["show_email"]
        showAddress                <- map["show_address"]
        showMobile                 <- map["show_mobile"]
        showDob                    <- map["show_dob"]
        showDesignation            <- map["show_designation"]
        showDepartment             <- map["show_department"]
        showOrg                    <- map["show_org"]
        showCompany                <- map["show_company"]
        showApps                   <- map["show_apps"]
        showGroup                  <- map["show_group"]
        showTask                   <- map["show_task"]
        showSchedule               <- map["show_schedule"]
        postEmailNotification     <- map["post_email_notification"]
        replyEmailNotification    <- map["reply_email_notification"]
    }

}
