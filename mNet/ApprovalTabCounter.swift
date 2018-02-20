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
    var completedCount:Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        approvalCount   <- map["approval_counter"]
        verifiedCount   <- map["verifier_counter"]
        completedCount  <- map["completed_counter"]
    }

}
