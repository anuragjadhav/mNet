//
//  ApprovalTabCounter.swift
//  mNet
//
//  Created by Nachiket Vaidya on 16/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalTabCounter: NSObject, Mappable {
    
    var approvalCount:Int = 0
    var verifiedCount:Int = 0
    var completedApprovalCount:Int = 0
    var completedVerificationCount:Int = 0
    var cancellednCount:Int = 0
    var rejectedCount:Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        approvalCount   <- map["approval_count"]
        verifiedCount   <- map["verification_count"]
        completedApprovalCount  <- map["completed_approval_count"]
        completedVerificationCount  <- map["completed_verification_count"]
        cancellednCount  <- map["cancelled_post_count"]
        rejectedCount  <- map["rejected_post_count"]
    }

}
