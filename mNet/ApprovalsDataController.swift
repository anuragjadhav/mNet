//
//  ApprovalsDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 17/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalsDataController: NSObject {

    var approvalsData:[ApprovalSection] = ApprovalSection.allSection
    
    var selectedSectionIndex:Int = 0
    var selectedSection:ApprovalSection? {
        return approvalsData[safe:selectedSectionIndex]
    }
    
    var selectedApprovalIndex:Int = 0
    var selectedApproval:Approval? {
        return selectedSection?.list[safe:selectedApprovalIndex]
    }
    
    let limit:Int = 15
    var startIndex:Int = 0
    var searchValue:String = ""
    var filterString:String?
    var reachedEnd:Bool = false
    
    func getApprovalsData(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void)  {
        
        var postData:[String:Any] = [String:Any]()
        postData["application_id"] = "1"
        postData["approval_list"] = selectedSection?.postKey
        postData["search_value"] = searchValue
        postData["limit"] = "\(limit)"
        postData["userId"] = "66"
        postData["UserEmail"] = "neha.kandpal@heromotocorp.com"
        postData["UserPass"] = "Neha@1234"
        postData["start"] = "\(startIndex)"
        
        if filterString != nil {
            postData["date_filter_key"] = filterString
        }
        
        WrapperManager.shared.approvalWrapper.getApprovalList(postParams: postData, onSuccess: { [unowned self] (approvalData) in
            
            let approvalList:[Approval] = approvalData.list
            
            if self.startIndex == 0 {
                self.selectedSection?.list = approvalList
            }
            
            else {
                self.selectedSection?.list.append(contentsOf: approvalList)
            }
            
            let tabCounter:ApprovalTabCounter = approvalData.tabCounter
            self.approvalsData[0].tabCount = tabCounter.approvalCount
            self.approvalsData[1].tabCount = tabCounter.verifiedCount
            self.approvalsData[2].tabCount = tabCounter.completedApprovalCount
            self.approvalsData[3].tabCount = tabCounter.completedVerificationCount
            self.approvalsData[4].tabCount = tabCounter.cancellednCount
            self.approvalsData[5].tabCount = tabCounter.rejectedCount
            
            self.startIndex += self.limit
            
            if approvalList.count == 0 || approvalList.count < self.limit {
                self.reachedEnd = true
            }
            
            onSuccess()
            
        }) { [unowned self] (errorMessage) in
            
            if self.selectedSection?.list.count ?? 0 == 0 {
                onFailure(errorMessage)
            }
            else {
                onSuccess()
            }
        }
    }
    
    func approvePost(replyMessage:String, approveType:String, nextApproval:String, onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void) {
    
        var postData:[String:Any] = [String:Any]()
        postData["reply_message"] = replyMessage
        postData["logged_in_user_id"] = User.loggedInUser()?.userId ?? ""
        postData["post_id"] = selectedApproval?.postId ?? ""
        postData["post_approve_type"] = approveType
        postData["next_approval_user"] = nextApproval
    
        WrapperManager.shared.approvalWrapper.approvePost(postParams: postData, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func rejectPost(replyMessage:String, onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void) {
        
        var postData:[String:Any] = [String:Any]()
        postData["reply_message"] = replyMessage
        postData["logged_in_user_id"] = User.loggedInUser()?.userId ?? ""
        postData["post_id"] = selectedApproval?.postId ?? ""
        postData["key_reject_type_id"] = "A"
        
        WrapperManager.shared.approvalWrapper.rejectPost(postParams: postData, onSuccess: onSuccess, onFailure: onFailure)
    }
    
}
