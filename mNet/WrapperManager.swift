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
    
    private override init() {
        
        super.init()
    }
}
