//
//  User.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class User: NSObject, Mappable {
    
    var email:String = ""
    var password:String = ""
    var userId:String = "66"
    var name:String = ""
    var status:String = ""
    
    var companyEmail:String = ""
    var postCount:Int = 0
    var applicationCount:Int = 0
    var profileVisitsCount:Int = 0
    var groupCount:Int = 0
    var tasksAssignedCount:Int = 0
    var completedTasksCount:Int = 0
    var notificationsCount:Int = 0
    var postStatusDays:Int = 0
    var profileImageString:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var gender:Int = 0
    var dob:String = ""
    var designation:String = ""
    var department:String = ""
    var mobile:String = ""
    var address:String = ""
    var displayStatus:String = ""
    var phone:String = ""
    var alternateEmail1:String = ""
    var alternateEmail2:String = ""
    var alternateEmail3:String = ""
    var about:String = ""
    var branchName:String = ""
    var branchId:Int = 0
    var branchStatus:Int = 0
    var companyName:String = ""
    var companyId:Int = 0
    var companyStatus:Int = 0
    var privateLink:String = ""
    var privateApiLink:String = ""
    var imageURLString:String = ""
    var version:String = ""
    var numberOfUsers:String = ""
    var organisationName:String = ""
    var organisationStatus:Int = 0
    var organisationId:Int = 0
    var domainName:String = ""
    var licenseStatus:String = ""
    var isLicenseAvailable:String = ""
    var isUserPrivate:String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        email <- map["LoginEmail"]
        password <- map["password"]
        //userId <- map["user_id"]
        name <- map["LoginName"]
        status <- map["Status"]
        companyEmail <- map["user_comp_email"]
        postCount <- map["post_count"]
        applicationCount <- map["application_count"]
        profileVisitsCount <- map["profile_visits_count"]
        groupCount <- map["group_count"]
        tasksAssignedCount <- map["task_assign_count"]
        completedTasksCount <- map["completed_task_count"]
        notificationsCount <- map["notification_count"]
        postStatusDays <- map["post_status_days"]
        profileImageString <- map["profile_img_link"]
        firstName <- map["user_first_name"]
        lastName <- map["user_last_name"]
        gender <- map["user_gender"]
        dob <- map["user_dob"]
        designation <- map["user_designation"]
        department <- map["user_department"]
        mobile <- map["user_mobile"]
        address <- map["user_address"]
        displayStatus <- map["display_status"]
        phone <- map["user_phone"]
        alternateEmail1 <- map["user_alternate_email_1"]
        alternateEmail2 <- map["user_alternate_email_2"]
        alternateEmail3 <- map["user_alternate_email_3"]
        about <- map["user_about"]
        branchName <- map["branch_name"]
        branchId <- map["branch_id"]
        branchStatus <- map["branch_status"]
        companyName <- map["comp_name"]
        companyId <- map["comp_id"]
        companyStatus <- map["comp_status"]
        privateLink <- map["private_link"]
        privateApiLink <- map["private_api_link"]
        imageURLString <- map["image_link"]
        version <- map["version"]
        numberOfUsers <- map["No_of_users"]
        organisationName <- map["org_name"]
        organisationStatus <- map["org_status"]
        organisationId <- map["org_id"]
        domainName <- map["domain_name"]
        licenseStatus <- map["license_status"]
        isLicenseAvailable <- map["is_license_available"]
        isUserPrivate <- map["is_user_private"]
    }
    
    //MARK: To Dictionary
    func toJSONPost() -> [String:Any] {
        
        var dictionary:[String:Any] = [String:Any]()
        dictionary["UserEmail"] = email
        dictionary["UserPass"] = password
        dictionary["UserId"] = userId
        return dictionary
    }
    
    func toJSONPostWithoutEmail() -> [String:Any] {
        
        var dictionary:[String:Any] = [String:Any]()
        dictionary["UserPass"] = password
        dictionary["UserId"] = userId
        return dictionary
    }
    
    func toJSONPostWithoutEmailDashboard() -> [String:Any] {
        
        var dictionary:[String:Any] = [String:Any]()
        dictionary["password"] = password
        dictionary["userid"] = userId
        return dictionary
    }
    
    func toJSONPostOnlyId() -> [String:Any] {
        
        var dictionary:[String:Any] = [String:Any]()
        dictionary["user_id"] = 66
        return dictionary
    }
    
    //MARK: Save And Retrieve
    func saveToUserDefaults() {
        
        let userDctionary:[String:Any] = self.toJSON()
        UserDefaults.standard.set(userDctionary, forKey: UserDefaultsKeys.loggedInUser)
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.loginStatus)
    }
    
    static func loggedInUser() -> User? {
        
        guard let userDctionary:[String:Any] = UserDefaults.standard.dictionary(forKey: UserDefaultsKeys.loggedInUser) else {
            return nil
        }
        
        return Mapper<User>().map(JSON: userDctionary)
    }
    
    static func isLoggedIn() -> Bool {
        
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.loginStatus)
    }
    
    static func logoutUser() {
        
        UserDefaults.standard.set(nil, forKey: UserDefaultsKeys.loggedInUser)
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.loginStatus)
    }
}
