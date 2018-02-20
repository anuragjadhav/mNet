//
//  ApprovalSection.swift
//  mNet
//
//  Created by Nachiket Vaidya on 16/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalSection: NSObject {

    var index:Int = 0
    var name:String = ""
    var list:[Approval] = [Approval]()
    var tabCount:Int = 0
    var postKey:String = ""
    
    static var allSection:[ApprovalSection] {
        
        let pendingApprovals:ApprovalSection = ApprovalSection()
        pendingApprovals.index = 0
        pendingApprovals.name = "Pending Approvals"
        pendingApprovals.postKey = "completed_list"
        
        let pendingVerifications:ApprovalSection = ApprovalSection()
        pendingVerifications.index = 1
        pendingVerifications.name = "Pending Verifications"
        pendingVerifications.postKey = "completed_list"
        
        let completedApprovals:ApprovalSection = ApprovalSection()
        completedApprovals.index = 2
        completedApprovals.name = "Completed Approvals"
        completedApprovals.postKey = "completed_list"
        
        let completedVerifications:ApprovalSection = ApprovalSection()
        completedVerifications.index = 3
        completedVerifications.name = "Completed Verifications"
        completedVerifications.postKey = "completed_list"
        
        return [pendingApprovals, pendingVerifications, completedApprovals, completedVerifications]
    }
}
