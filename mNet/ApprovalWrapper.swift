//
//  ApprovalWrapper.swift
//  mNet
//
//  Created by Nachiket Vaidya on 16/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalWrapper: NSObject {

    func getApprovalList(postParams:[String:Any], onSuccess:@escaping ((list:[Approval],tabCounter:ApprovalTabCounter)) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.getApprovalList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                
                guard let responseDict:[[String:Any]] = commonResponse.responseData as? [[String:Any]] else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                    return
                }
                
                let approvalList:[Approval] = Mapper<Approval>().mapArray(JSONArray: responseDict)
                
                onSuccess((approvalList, commonResponse.approvalTabCounter!))
            }
                
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
        }
    }
    
    func approvePost(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.approvePost, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                
                if let message:String = commonResponse.responseData as? String {
                    onSuccess(message)
                }
                
                else {
                    onSuccess("Post Approved")
                }
            }
                
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: commonResponse.errorString))
                return
            }
        }
    }
    
    func verifyPost(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.verifyPost, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                
                if let message:String = commonResponse.responseData as? String {
                    onSuccess(message)
                }
                    
                else {
                    onSuccess("Post Verified")
                }
            }
                
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
        }
    }
    
    func rejectPost(postParams:[String:Any], onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.rejectPost, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                
                if let message:String = commonResponse.responseData as? String {
                    onSuccess(message)
                }
                    
                else {
                    onSuccess("Post Rejected")
                }
            }
                
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
        }
    }
}
