//
//  WrapperManager.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class WrapperManager: NSObject {
    
    static let shared:WrapperManager = WrapperManager()
    
    let settingsWrapper:SettingsWrapper = SettingsWrapper()
    let loginWrapper:LoginWrapper = LoginWrapper()
    let conversationWrapper:ConversationsWrapper = ConversationsWrapper()
    let profileWrapper:ProfileWrapper = ProfileWrapper()
    let notifiactionWrapper:NotificationWrapper = NotificationWrapper()
    let peopleWrapper:PeopleWrapper = PeopleWrapper()
    let dashboardWrapper:DashboardWrapper = DashboardWrapper()
    let approvalWrapper:ApprovalWrapper = ApprovalWrapper()
    
    private override init() {
        super.init()
    }
    
    func getErrorMessage(message:String?) -> String {
        
        if Reachability.isConnectedToNetwork() {
            if message != nil && (message! != "0" || message != "1") {
                return message!
            }
            return "Something went wrong. Please try again."
            
        }
        else {
            return AlertMessages.connectToInternet
        }
    }
}
