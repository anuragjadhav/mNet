//
//  Option.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SettingOption: NSObject {
    
    var settingOptionName:String?
    var settingOptionDescription:String?
    var isSettingOn:String?
    
    convenience init(_ optionName:String, _ optionDescription:String, _ isSettingOn:String) {
        
        self.init()
        self.settingOptionName = optionName
        self.settingOptionDescription = optionDescription
        self.isSettingOn = isSettingOn
    }
}
