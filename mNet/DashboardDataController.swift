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
    
    var statsResponseSuccess:Bool = false
    var statsResponseFailure:Bool = false
    var appsResponseSuccess:Bool = false
    var appsResponseFailure:Bool = false
    
    func getDashboardData(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
    
        statsResponseSuccess = false
        statsResponseFailure = false
        appsResponseSuccess = false
        appsResponseFailure = false
        
        getDashboardStats(onSuccess: { [unowned self] in
            
            self.statsResponseSuccess = true
            self.statsResponseFailure = false
            if self.appsResponseSuccess || self.appsResponseFailure {
                onSuccess()
            }
            
        }) { (errorMessage) in
            
            self.statsResponseSuccess = false
            self.statsResponseFailure = true
            
            if self.appsResponseSuccess {
                onSuccess()
            }
            else if self.appsResponseFailure {
                onFailure(errorMessage)
            }
            
        }
        
        getDashboardApps(onSuccess: {
            
            self.appsResponseSuccess = true
            self.appsResponseFailure = false
            if self.statsResponseSuccess || self.statsResponseFailure {
                onSuccess()
            }
            
        }) { (errorMessage) in
            
            self.appsResponseSuccess = false
            self.appsResponseFailure = true
            if self.statsResponseSuccess {
               onSuccess()
            }
            else if self.statsResponseFailure {
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
        
        let postParams:[String:Any] = User.loggedInUser()!.toJSONPostOnlyCode()
        
        WrapperManager.shared.dashboardWrapper.getDashboardApps(postParams: postParams, onSuccess: { [unowned self] (userApps) in
            
            self.appsList = userApps
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }

}
