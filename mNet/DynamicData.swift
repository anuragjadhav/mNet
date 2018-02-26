//
//  DynamicData.swift
//  mNet
//
//  Created by Nachiket Vaidya on 17/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class DynamicData: NSObject, Mappable {

    var title:String = ""
    var value:String = "-"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        title <- map["label_title"]
        value <- map["label_value"]
    }
}
