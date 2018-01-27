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
      
    }

}
