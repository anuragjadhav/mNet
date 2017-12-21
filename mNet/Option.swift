//
//  Option.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class Option: NSObject {
    
    var optionName:String?
    var optionDescription:String?
    var isOn:Bool?
    
    override init() {
        super.init()
    }
    
    class func initWith(_ optionName:String , _ optionDescription:String) -> Option {
        
        let option = Option()
        option.optionName = optionName
        option.optionDescription = optionDescription
        
        return option
    }
}
