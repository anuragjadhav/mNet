//
//  People.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/30/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class People: NSObject,Mappable {
    
    var userName : String?
    var companyName : String?
    var branchName : String?
    var designation : String?
    var department : String?
    var imageUrl :String?
    var userId :String?
    var blockStatus :String? = "Unblock"
    var iblocked :String?
    var meblocked :String?
    var email:String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        userName <- map["username"]
        companyName <- map["comp_name"]
        branchName <- map["branch_name"]
        designation <- map["user_designation"]
        department <- map["user_department"]
        imageUrl <- map["profile_img_link"]
        userId <- map["user_id"]
        blockStatus <- map["BlockStatus"]
        iblocked <- map["Iblocked"]
        meblocked <- map["meblocked"]
        email <- map["user_email"]
    }

}
