//
//  User.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class User: NSObject, Mappable {
    
    var email:String = "falgunip@mediawareonline.com"
    var password:String = "Tt@123456"
    var userId:String = "70"
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        email <- map["UserEmail"]
        password <- map["UserPass"]
        userId <- map["UserId"]
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
        
        return user.userId != ""
    }
    
    static func logoutUser() {
        
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.loggedInUser)
    }
}
