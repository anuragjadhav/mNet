//
//  Constants.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

struct URLS {
    
    static let baseURL:String = "Dashboard"
    static let getSettings:String = "Dashboard"
    static let setSettings:String = "Dashboard"
}

struct ColorConstants {
    
    static let kBrownColor: UIColor = UIColor(red: 97.0/255.0, green: 72.0/255.0, blue: 57.0/255.0, alpha: 1.0)
    static let kBlueColor: UIColor = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1.0)
    static let kRedColor: UIColor = UIColor(red: 221.0/255.0, green: 75.0/255.0, blue: 57.0/255.0, alpha: 1.0)
}

struct SettingOptions {
    
    static let aboutMe = "About Me"
    static let password = "Pasword"
    static let privacySettings = "Privacy Settings"
    static let appSettings = "App Settings"
    static let emailPreferences = "Email Preferences"
    static let groups = "Groups"
    static let people = "People"
}


struct PrivacySettingOptions {
    
    static let myEmailID:String = "My Email ID"
    static let myEmailIDDescription:String = "Show your Email ID to others users."
    
    static let myAddress:String = "My Address"
    static let myAddressDescription:String = "Show your Address to others users."
    
    static let myMobile:String = "My Mobile"
    static let myMobileDescription:String = "Show your Mobile to others users."
    
    static let myBirthday:String = "My Birthday"
    static let myBirthdayDescription:String = "Show your Birthday to others users."
    
    static let mydesignation:String = "My Designation"
    static let mydesignationDescription:String = "Show your Designation to others users."
    
    static let mydepartment:String = "My Department"
    static let mydepartmentDescription:String = "Show your Department to others users."
    
    static let myOrganization:String = "My Organization"
    static let myOrganizationDescription:String = "Show your Organization to others users."
    
    static let myCompany:String = "My Company"
    static let myCompanyDescription:String = "Show your Company to others users."
    
    static let myApplication:String = "My Application"
    static let myApplicationDescription:String = "Show your Applications to others users."
    
    static let myGroup:String = "My Group"
    static let myGroupDescription:String = "Show your Group to others users."
    
    static let myTask:String = "My Task"
    static let myTaskDescription:String = "Show your Task to others users."
    
    static let mySchedule:String = "My schedule"
    static let myScheduleDescription:String = "Show your Schedule to others users."
}


struct CellIdentifiers {
    
    static let dashboardMyAppsTableView:String = "DashboardMyAppsTableViewCell"
    static let conversationListTableView:String = "conversationListTableViewCell"
    static let approvalsSectionsCollectionView:String = "approvalSectionsCollectionViewCell"
    static let pendingApprovalsTableViewCell:String = "pendingApprovalsTableViewCell"
    static let filterTableViewCell:String = "filterTableViewCell"
    static let optionTableViewCell:String = "optionTableViewCell"
    static let pendingApprovalsCollectionView:String = "pendingApprovalsCollectionViewCell"
}

struct TabNames {
    
    static let dashboard:String = "Dashboard"
    static let conversations:String = "Conversations"
    static let settings:String = "Settings"
    static let notifications:String = "Notifications"
}

struct StoryboardIDs {
    
    static let peopleViewController:String = "PeopleViewController"
}

extension UIStoryboard {
    
    static let dashboard:UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
    static let conversations:UIStoryboard = UIStoryboard(name: "Conversation", bundle: nil)
    static let settings:UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
    static let notifications:UIStoryboard = UIStoryboard(name: "Notifications", bundle: nil)
    static let profile:UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
}

extension UIFont {
    
    static func boldAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Bold", size: fontSize)!
    }
    
    static func semiBoldAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Semibold", size: fontSize)!
    }
    
    static func mediumAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Medium", size: fontSize)!
    }
    
    static func regularAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Regular", size: fontSize)!
    }
    
    static func lightAppFont(fontSize: CGFloat) -> UIFont {
        
        return UIFont(name: "SanFranciscoDisplay-Light", size: fontSize)!
    }
}

