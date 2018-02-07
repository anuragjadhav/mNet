//
//  User.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class User: NSObject, Mappable {
    
    var email:String = "sreekumaran.p@heromotocorp.com"
    var password:String = "Sree@123"
    var userId:String = "42"
    
//    var email:String = ""
//    var password:String = ""
//    var userId:String = ""
    var name:String = ""
    var status:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
//        email <- map["LoginEmail"]
//        password <- map["password"]
//        userId <- map["user_id"]
        name <- map["LoginName"]
        status <- map["Status"]
    }
    
    //MARK: To Dictionary
    func toJSONPost() -> [String:Any] {
        
        var dictionary:[String:Any] = [String:Any]()
        dictionary["UserEmail"] = email
        dictionary["UserPass"] = password
        dictionary["UserId"] = userId
        return dictionary
    }
    
    //MARK: Save And Retrieve
    func saveToUserDefaults() {
        
        let userDctionary:[String:Any] = self.toJSON()
        UserDefaults.standard.set(userDctionary, forKey: UserDefaultsKeys.loggedInUser)
    }
    
    static func loggedInUser() -> User? {
        
        guard let userDctionary:[String:Any] = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.loggedInUser) else {
            return nil
        }
        
        return Mapper<User>().map(JSON: userDctionary)
    }
    
    static func isLoggedIn() -> Bool {
        
        guard let userDctionary:[String:Any] = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.loggedInUser) else {
            return false
        }
        
        guard let user:User = Mapper<User>().map(JSON: userDctionary) else {
            return false
        }
        
        return !user.userId.isEmpty
    }
    
    static func logoutUser() {
        
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.loggedInUser)
    }
}
