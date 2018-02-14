//
//  DashboardDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 14/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class DashboardDataController: NSObject {
    
    var numberOfDays:String = "180"
    
    var stats:DashboardStats?
    var appsList:[UserApp] = [UserApp]()
    
    var statsResponse:Bool = false
    var appsResponse:Bool = false
    
    
    func getDashboardData(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
    
        statsResponse = false
        appsResponse = false
        
        getDashboardStats(onSuccess: { [unowned self] in
            
            self.statsResponse = true
            if self.appsResponse {
                onSuccess()
            }
            
        }) { (errorMessage) in
            
            self.statsResponse = true
            if self.appsResponse {
                onFailure(errorMessage)
           }
        }
        
        getDashboardApps(onSuccess: {
            
            self.appsResponse = true
            if self.statsResponse {
                onSuccess()
            }
            
        }) { (errorMessage) in
            
            self.appsResponse = true
            if self.statsResponse {
                onFailure(errorMessage)
            }
        }
    }
        
    func getDashboardStats(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        var postParams:[String:Any] = User.loggedInUser()!.toJSONPostWithoutEmailDashboard()
        postParams[DictionaryKeys.Dashboard.days] = numberOfDays
        
        WrapperManager.shared.dashboardWrapper.getDashboardStats(postParams: postParams, onSuccess: { [unowned self] (dashboardStats) in
            
            self.stats = dashboardStats
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func getDashboardApps(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let postParams:[String:Any] = User.loggedInUser()!.toJSONPostOnlyId()
        
        WrapperManager.shared.dashboardWrapper.getDashboardApps(postParams: postParams, onSuccess: { [unowned self] (userApps) in
            
            self.appsList = userApps
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }

}
