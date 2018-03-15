//
//  PrivacySettings.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit


class Settings:NSObject, Mappable {
    
    var showEmail : String?
    var showAddress : String?
    var showMobile : String?
    var showDob : String?
    var showDesignation :String?
    var showDepartment : String?
    var showOrg : String?
    var showCompany :String?
    var showApps : String?
    var showGroup : String?
    var showTask : String?
    var showSchedule : String?
    var postEmailNotification : String?
    var replyEmailNotification : String?
    var postNotification : String?
    var reminderDays : String? = "1"
    
    
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
        postNotification    <- map["post_notification"]
        reminderDays    <- map["reminder_days"]

    }

}
