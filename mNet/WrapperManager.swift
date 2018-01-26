//
//  WrapperManager.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

let sharedManager = WrapperManager()

class WrapperManager: NSObject {
    
    let settingsWrapper:SettingsWrapper
    
    override init() {
        
        self.settingsWrapper = SettingsWrapper()
    }
}
