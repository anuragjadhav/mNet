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
    var isSettingOn:Int?
    
    override init() {
        super.init()
    }
    
    class func initWith(_ optionName:String , _ optionDescription:String ,_ isSettingOn:Int) -> SettingOption {
        
        let option = SettingOption()
        option.settingOptionName = optionName
        option.settingOptionDescription = optionDescription
        option.isSettingOn = isSettingOn
        
        return option
    }
}
