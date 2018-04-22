//
//  SettingsDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SettingsProfileDataController: NSObject {
    
    public private(set) var  settingOptionsArray:[String] = []
    public private(set) var  privacySettingOptionsArray:[SettingOption] = []
    
    var selectedPrivacySettingOption:SettingOption?
    var settings:Settings?
    var profile:Profile?
    
    override init()
    {
        super.init()
        self.setupSettingOptionsArray()
    }
    
    private func setupSettingOptionsArray() {
        
        settingOptionsArray.append(SettingOptions.aboutMe)
        settingOptionsArray.append(SettingOptions.password)
        settingOptionsArray.append(SettingOptions.privacySettings)
        settingOptionsArray.append(SettingOptions.emailPreferences)
        settingOptionsArray.append(SettingOptions.people)
        settingOptionsArray.append(SettingOptions.blockedUsers)
        settingOptionsArray.append(SettingOptions.logout)
    }
    
     func setupPrivacySettingOptionsArray() {
        
        privacySettingOptionsArray.removeAll()
        
        let emailSettingOption = SettingOption(PrivacySettingOptions.myEmailID, PrivacySettingOptions.myEmailIDDescription,(settings?.showEmail)!)
        privacySettingOptionsArray.append(emailSettingOption)
        
        let addressSettingOption = SettingOption(PrivacySettingOptions.myAddress, PrivacySettingOptions.myAddressDescription,(settings?.showAddress)!)
        privacySettingOptionsArray.append(addressSettingOption)
        
        let mobileSettingOption = SettingOption(PrivacySettingOptions.myMobile, PrivacySettingOptions.myMobileDescription,(settings?.showMobile)!)
        privacySettingOptionsArray.append(mobileSettingOption)
        
        let birthdaySettingOption = SettingOption(PrivacySettingOptions.myBirthday, PrivacySettingOptions.myBirthdayDescription,(settings?.showDob)!)
        privacySettingOptionsArray.append(birthdaySettingOption)
        
        let designationSettingOption = SettingOption(PrivacySettingOptions.mydesignation, PrivacySettingOptions.mydesignationDescription,(settings?.showDesignation)!)
        privacySettingOptionsArray.append(designationSettingOption)
        
        let departmentSettingOption = SettingOption(PrivacySettingOptions.mydepartment, PrivacySettingOptions.mydepartmentDescription,(settings?.showDepartment)!)
        privacySettingOptionsArray.append(departmentSettingOption)
        
        let organizationSettingOption = SettingOption(PrivacySettingOptions.myOrganization, PrivacySettingOptions.myOrganizationDescription,(settings?.showOrg)!)
        privacySettingOptionsArray.append(organizationSettingOption)
        
        let companySettingOption = SettingOption(PrivacySettingOptions.myCompany, PrivacySettingOptions.myCompanyDescription,(settings?.showCompany)!)
        privacySettingOptionsArray.append(companySettingOption)
        
        let applicationsSettingOption = SettingOption(PrivacySettingOptions.myApplication, PrivacySettingOptions.myApplicationDescription,(settings?.showApps)!)
        privacySettingOptionsArray.append(applicationsSettingOption)
        
        let groupSettingOption = SettingOption(PrivacySettingOptions.myGroup, PrivacySettingOptions.myGroupDescription,(settings?.showGroup)!)
        privacySettingOptionsArray.append(groupSettingOption)
        
        let taskSettingOption = SettingOption(PrivacySettingOptions.myTask, PrivacySettingOptions.myTaskDescription,(settings?.showTask)!)
        privacySettingOptionsArray.append(taskSettingOption)
        
        let scheduleSettingOption = SettingOption(PrivacySettingOptions.mySchedule, PrivacySettingOptions.myScheduleDescription,(settings?.showSchedule)!)
        privacySettingOptionsArray.append(scheduleSettingOption)
    }
    
    
    func getSettingOfUser(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        let user:User = User.loggedInUser()!
        
        WrapperManager.shared.settingsWrapper.getSettingOfUser(postObject: user, onSuccess: { [unowned self] (settings) in
            
            self.settings = settings
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func setPrivacySettingOfUser(onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
        
        var parameter:String?
        
        if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myEmailID)
        {
            parameter = "show_email"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myAddress)
        {
            parameter = "show_address"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myMobile)
        {
            parameter = "show_mobile"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myBirthday)
        {
            parameter = "show_dob"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.mydesignation)
        {
            parameter = "show_designation"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.mydepartment)
        {
            parameter = "show_department"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myOrganization)
        {
            parameter = "show_org"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myApplication)
        {
            parameter = "show_apps"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myCompany)
        {
            parameter = "show_company"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myGroup)
        {
            parameter = "show_group"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.myTask)
        {
            parameter = "show_task"
        }
        else if(selectedPrivacySettingOption?.settingOptionName == PrivacySettingOptions.mySchedule)
        {
            parameter = "show_schedule"
        }
        
        //set parameters to post
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = user.toJSONPost()
        postParams["parameter"] = parameter
        postParams["value"] = selectedPrivacySettingOption?.isSettingOn
        
        WrapperManager.shared.settingsWrapper.setPrivacySettingOfUser(postParams: postParams, onSuccess: { (displayMessage) in
            
            onSuccess(displayMessage)
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func setEmailPreferenceSetting(conversationvalue:String,commentsvalue:String,approvalvalue:String,remindDaysvalue:String,onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){
        
        let user:User = User.loggedInUser()!
        
        //set parameters to post
        var postParams:[String:Any] = [String:Any]()
        postParams["user_code"] = user.userCode
        postParams["reminder_days"] = remindDaysvalue
        postParams["email_pref_conversation"] = conversationvalue
        postParams["email_pref_comments"] = commentsvalue
        postParams["email_pref_approval"] = approvalvalue
        
        WrapperManager.shared.settingsWrapper.setEmailPreferenceSettingOfUser(postParams: postParams, onSuccess: { [unowned self] (displayMessage) in
            
            self.settings?.postNotification = conversationvalue
            self.settings?.reminderDays = remindDaysvalue
            self.settings?.replyEmailNotification = approvalvalue
            self.settings?.postEmailNotification = commentsvalue

            onSuccess(displayMessage)
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func getUserProfile(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        let user:User = User.loggedInUser()!
        
        WrapperManager.shared.profileWrapper.getProfileOfUser(postObject: user, onSuccess: { [unowned self] (profile) in
            
            self.profile = profile
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func resetNewPassword(oldPassword:String,newPassword:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        let user:User = User.loggedInUser()!
        
        //set parameters to post
        var postParams:[String:Any] = [String:Any]()
        postParams["userEmail"] = user.email
        postParams["newPassword"] = newPassword
        postParams["oldPassword"] = oldPassword
        postParams["requestFrom"] = "MobileApp"
        postParams["platform"] = "iOS"
        
        WrapperManager.shared.settingsWrapper.resetNewPassword(postParams: postParams, onSuccess: {
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func deRegisterDeviceToken(onSuccess:@escaping () -> Void , onFailure : @escaping () -> Void) {
        
        guard var postParams:[String:Any] = User.loggedInUser()?.toJSONPostWithPublicUserIdForTokenRegistration() else {
            onFailure()
            return
        }
        
        guard let deviceToken:String = UserDefaults.standard.string(forKey: UserDefaultsKeys.deviceToken) else {
            onSuccess()
            return
        }
        
        postParams[DictionaryKeys.DeviceRegistration.deviceToken] = deviceToken
        
        WrapperManager.shared.loginWrapper.registerDeviceToken(isLogout: true, postParams:postParams, onSuccess: {
            onSuccess()
            
        }) {
            onFailure()
        }
    }
}
