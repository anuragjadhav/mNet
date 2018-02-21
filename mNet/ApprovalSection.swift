//
//  ApprovalSection.swift
//  mNet
//
//  Created by Nachiket Vaidya on 16/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

public enum ApproveButtonStatus {
    case approve
    case verify
    case hide
}

class ApprovalSection: NSObject {

    var index:Int = 0
    var name:String = ""
    var list:[Approval] = [Approval]()
    var tabCount:Int = 0
    var postKey:String = ""
    var buttonStatus:ApproveButtonStatus = .approve
    
    static var allSection:[ApprovalSection] {
    
        let pendingApprovals:ApprovalSection = ApprovalSection()
        pendingApprovals.index = 0
        pendingApprovals.name = "Pending Approvals"
        pendingApprovals.postKey = "approval_list"
        pendingApprovals.buttonStatus = .approve
        
        let pendingVerifications:ApprovalSection = ApprovalSection()
        pendingVerifications.index = 1
        pendingVerifications.name = "Pending Verifications"
        pendingVerifications.postKey = "verified_list"
        pendingVerifications.buttonStatus = .verify
        
        let completedApprovals:ApprovalSection = ApprovalSection()
        completedApprovals.index = 2
        completedApprovals.name = "Completed Approvals"
        completedApprovals.postKey = "completed_approval"
        completedApprovals.buttonStatus = .hide
        
        let completedVerifications:ApprovalSection = ApprovalSection()
        completedVerifications.index = 3
        completedVerifications.name = "Completed Verifications"
        completedVerifications.postKey = "completed_verification"
        completedVerifications.buttonStatus = .hide
        
        let cancelled:ApprovalSection = ApprovalSection()
        cancelled.index = 4
        cancelled.name = "Cancelled"
        cancelled.postKey = "cancelled_post"
        cancelled.buttonStatus = .hide
        
        let rejected:ApprovalSection = ApprovalSection()
        rejected.index = 5
        rejected.name = "Rejected"
        rejected.postKey = "rejected_post"
        rejected.buttonStatus = .hide
        
        return [pendingApprovals, pendingVerifications, completedApprovals, completedVerifications, cancelled, rejected]
    }
}
