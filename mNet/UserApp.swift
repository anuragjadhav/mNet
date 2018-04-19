//
//  UserApp.swift
//  mNet
//
//  Created by Nachiket Vaidya on 09/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class UserApp: NSObject, Mappable {
    
    var appId:String = ""
    var appAdminId:String = ""
    var appURL:URL?
    var appUserId:String = ""
    var appType:String = ""
    var createdOn:String = ""
    var fabStatus:String = ""
    var appName:String = ""
    var appDescription:String = ""
    var appLogoLink:String = ""
    var appImageLink:String = ""
    var appWidth:String = ""
    var appHeight:String = ""
    var allowFullScreen:String = ""
    var applicationOpenIn:String = ""
    var appSequence:String = ""
    var branchName:String = ""
    var companyName:String = ""
    var organisationName:String = ""
    var recieverName:String = ""
    var appCode:String = ""
    var allowInMobile:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        appId <- map["app_id"]
        appAdminId <- map["app_admin_id"]
        appURL <- (map["app_url"],URLTransform())
        appUserId <- map["app_userid"]
        appType <- map["app_type"]
        createdOn <- map["created_on"]
        fabStatus <- map["fab_status"]
        appName <- map["app_name"]
        appDescription <- map["app_description"]
        appLogoLink <- map["app_logo_link"]
        appImageLink <- map["app_img_link"]
        appWidth <- map["app_width"]
        appHeight <- map["app_height"]
        allowFullScreen <- map["allow_fullscreen"]
        applicationOpenIn <- map["application_open_in"]
        appSequence <- map["app_sequence"]
        branchName <- map["branch_name"]
        companyName <- map["comp_name"]
        organisationName <- map["org_name"]
        recieverName <- map["recieverName"]
        appCode <- map["code"]
        allowInMobile <- map["allow_in_mobile"]
    }
    
}
