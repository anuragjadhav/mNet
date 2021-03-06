//
//  DashboardWrapper.swift
//  mNet
//
//  Created by Nachiket Vaidya on 14/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class DashboardWrapper: NSObject {

    func getDashboardStats(postParams:[String:Any], onSuccess:@escaping (DashboardStats) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.getDashboardStatistics, method: .post, parameters:postParams , encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                
                guard let statsDictionary:[String:Any] = commonResponse.responseData as? [String:Any] else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                    return
                }
                
                guard let stats:DashboardStats = DashboardStats(JSON: statsDictionary) else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                    return
                }
                
                onSuccess(stats)
            }
            else if(commonResponse.errorString == DictionaryKeys.APIResponse.invaidCredentialsError)
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                return
            }
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
        }
    }
    
    func getDashboardApps(postParams:[String:Any], onSuccess:@escaping ([UserApp]) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.getUserAppsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                
                guard let appsDictionaryArray:[[String:Any]] = commonResponse.responseData as? [[String:Any]] else {
                    onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                    return
                }
                
                let apps:[UserApp] = Mapper<UserApp>().mapArray(JSONArray: appsDictionaryArray)
                onSuccess(apps)
            }
            else if(commonResponse.errorString == DictionaryKeys.APIResponse.invaidCredentialsError)
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                return
            }
                
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
        }
    }
    
    func setAppPriority(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.setAppPriority, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
            
            if commonResponse.noError {
                onSuccess()
            }
            else if(commonResponse.errorString == DictionaryKeys.APIResponse.invaidCredentialsError)
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                return
            }
            else {
                onFailure(WrapperManager.shared.getErrorMessage(message: nil))
                return
            }
        }
    }
}
