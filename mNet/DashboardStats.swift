//
//  DashboardStats.swift
//  mNet
//
//  Created by Nachiket Vaidya on 09/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class DashboardStats: NSObject, Mappable {
    
    var unreadPosts:String = "0"
    var totalPosts:String = ""
    var pendingApprovalRequests:Int = 0
    var totalApprovalRequests:Int = 0
    var pendingAgreeRequests:Int = 0
    var totalAgreeRequests:String = ""
    var publicURL:URL?
    var publicName:String = ""
    var publicImage:URL?
    var privaleURL:URL?
    var privateName:String = ""
    var privateImage:URL?
    var status:String = ""
    var publicWebserviceURL:URL?
    var privateWebserviceURL:URL?
    var imageURL:URL?
    var notificationCount:String = "0"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        unreadPosts <- map["unread_posts"]
        totalPosts <- map["total_posts"]
        pendingApprovalRequests <- map["pending_approval_requests"]
        totalApprovalRequests <- map["total_approval_requests"]
        pendingAgreeRequests <- map["pending_agree_requests"]
        totalAgreeRequests <- map["total_agree_requests"]
        publicURL <- (map["public_url"],URLTransform())
        publicName <- map["public_name"]
        publicImage <- (map["public_image"],URLTransform())
        privaleURL <- (map["private_url"],URLTransform())
        privateName <- map["private_name"]
        privateImage <- (map["private_image"],URLTransform())
        status <- map["status"]
        publicWebserviceURL <- (map["public_webservice_url"],URLTransform())
        privateWebserviceURL <- (map["private_webservice_url"],URLTransform())
        imageURL <- (map["image_url"],URLTransform())
        notificationCount <- map["notification_count"]
    }
}
