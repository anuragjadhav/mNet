//
//  CommonResponse.swift
//  mNet
//
//  Created by Nachiket Vaidya on 09/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class CommonResponse: NSObject, Mappable {

    static let noErrorString:String = "0"
    static let noErrorInt:Int = 0
    
    var errorString:String = "0"
    var errorInt:Int = 0
    var responseData:Any?
    var noError:Bool {
        return errorString == CommonResponse.noErrorString && errorInt == CommonResponse.noErrorInt
    }
    
    var approvalTabCounter:ApprovalTabCounter?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        errorString     <- map["error"]
        errorInt        <- map["error"]
        responseData    <- map["status"]
        approvalTabCounter <- map["tabCounter"]
    }
    
}
