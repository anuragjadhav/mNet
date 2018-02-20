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
                onFailure("Something went wrong. Please try again.")
                return
            }
            
            if commonResponse.noError {
                
                guard let statsDictionary:[String:Any] = commonResponse.responseData as? [String:Any] else {
                    onFailure("Something went wrong. Please try again.")
                    return
                }
                
                guard let stats:DashboardStats = DashboardStats(JSON: statsDictionary) else {
                    onFailure("Something went wrong. Please try again.")
                    return
                }
                
                onSuccess(stats)
            }
            
            else {
                onFailure("Something went wrong. Please try again.")
                return
            }
        }
    }
    
    func getDashboardApps(postParams:[String:Any], onSuccess:@escaping ([UserApp]) -> Void , onFailure : @escaping (String) -> Void) {
        
        request(URLS.getUserAppsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseObject { (response:DataResponse<CommonResponse>) in
            
            guard let commonResponse:CommonResponse = response.result.value else {
                onFailure("Something went wrong. Please try again.")
                return
            }
            
            if commonResponse.noError {
                
                guard let responseDict:[String:Any] = commonResponse.responseData as? [String:Any] else {
                    onFailure("Something went wrong. Please try again.")
                    return
                }
                
                guard let appsDictionaryArray:[[String:Any]] = responseDict["records"] as? [[String:Any]] else {
                    onFailure("Something went wrong. Please try again.")
                    return
                }
                
                let apps:[UserApp] = Mapper<UserApp>().mapArray(JSONArray: appsDictionaryArray)
                onSuccess(apps)
            }
                
            else {
                onFailure("Something went wrong. Please try again.")
                return
            }
        }
        
    }
}