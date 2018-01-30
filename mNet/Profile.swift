//
//  Profile.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class Profile: NSObject,Mappable {
    
    var firstName : String?
    var lastName : String?
    var dob : String?
    var gender : String?
    var phoneNo : String?
    var address : String?
    var about : String?
    var branchName : String?
    var designation : String?
    var companyName : String?
    var department : String?
    var mobileNo : String?
    var companyId : String?
    var organizationId : String?
    var organizationName : String?
    var imageUrl :String?
    var applicationCount : String?
    var profileVisitsCount : String?
    var groupCount : String?

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        firstName <- map["user_first_name"]
        lastName <- map["user_last_name"]
        dob <- map["user_dob"]
        gender <- map["user_gender"]
        phoneNo <- map["user_phone"]
        address <- map["user_address"]
        about <- map["user_about"]
        branchName <- map["branch_name"]
        designation <- map["user_designation"]
        companyName <- map["comp_name"]
        department <- map["user_department"]
        mobileNo <- map["user_mobile"]
        companyId <- map["comp_id"]
        organizationId <- map["org_id"]
        organizationName <- map["org_name"]
        imageUrl <- map["image_link"]
        applicationCount <- map["application_count"]
        profileVisitsCount <- map["profile_visits_count"]
        groupCount <- map["group_count"]
    }
}
