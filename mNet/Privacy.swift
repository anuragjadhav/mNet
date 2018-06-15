//
//  Privacy.swift
//  mNet
//
//  Created by MobCast Innovations on 16/06/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class Privacy: NSObject,Mappable {
    
    var showEmail : String? = "0"
    var showDob : String? = "0"
    var showUsername : String? = "0"
    var showDesignation : String? = "0"
    var showDepartment : String? = "0"
    var showMobile : String? = "0"
    var showOrganisation : String? = "0"
    var showCompany : String? = "0"
    var showAddress : String? = "0"
    var showApps : String? = "0"
    var showTask : String? = "0"
    var showGroups : String? = "0"
    var showSchedule : String? = "0"

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        showEmail <- map["show_email"]
        showDob <- map["show_dob"]
        showUsername <- map["show_username"]
        showDesignation <- map["show_designation"]
        showDepartment <- map["show_department"]
        showMobile <- map["show_mobile"]
        showOrganisation <- map["show_org"]
        showCompany <- map["show_company"]
        showAddress <- map["show_address"]
        showApps <- map["show_apps"]
        showTask <- map["show_task"]
        showGroups <- map["show_group"]
        showSchedule <- map["show_schedule"]
    }

}
