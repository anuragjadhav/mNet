//
//  SettingsDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SettingsDataController: NSObject {
    
    public private(set) var  optionsArray:[String] = []
    
    override init()
    {
        super.init()
        self.setupOptionsArray()
    }
    
    private func setupOptionsArray() {
        
        optionsArray.append(SettingOptions.aboutMe)
        optionsArray.append(SettingOptions.password)
        optionsArray.append(SettingOptions.privacySettings)
        optionsArray.append(SettingOptions.appSettings)
        optionsArray.append(SettingOptions.emailPreferences)
        optionsArray.append(SettingOptions.groups)
    }
}
