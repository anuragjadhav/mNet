//
//  SettingsDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SettingsDataController: NSObject {
    
    public private(set) var  settingOptionsArray:[String] = []
    public private(set) var  privacySettingOptionsArray:[Option] = []

    override init()
    {
        super.init()
        self.setupSettingOptionsArray()
        self.setupPrivacySettingOptionsArray()
    }
    
    private func setupSettingOptionsArray() {
        
        settingOptionsArray.append(SettingOptions.aboutMe)
        settingOptionsArray.append(SettingOptions.password)
        settingOptionsArray.append(SettingOptions.privacySettings)
        settingOptionsArray.append(SettingOptions.appSettings)
        settingOptionsArray.append(SettingOptions.emailPreferences)
        settingOptionsArray.append(SettingOptions.groups)
        settingOptionsArray.append(SettingOptions.people)
    }
    
    private func setupPrivacySettingOptionsArray() {
        
        let emailSettingOption = Option.initWith(PrivacySettingOptions.myEmailID, PrivacySettingOptions.myEmailIDDescription)
        privacySettingOptionsArray.append(emailSettingOption)
        
        let addressSettingOption = Option.initWith(PrivacySettingOptions.myAddress, PrivacySettingOptions.myAddressDescription)
        privacySettingOptionsArray.append(addressSettingOption)
        
        let mobileSettingOption = Option.initWith(PrivacySettingOptions.myMobile, PrivacySettingOptions.myMobileDescription)
        privacySettingOptionsArray.append(mobileSettingOption)
        
        let birthdaySettingOption = Option.initWith(PrivacySettingOptions.myBirthday, PrivacySettingOptions.myBirthdayDescription)
        privacySettingOptionsArray.append(birthdaySettingOption)
        
        let designationSettingOption = Option.initWith(PrivacySettingOptions.mydesignation, PrivacySettingOptions.mydesignationDescription)
        privacySettingOptionsArray.append(designationSettingOption)
        
        let departmentSettingOption = Option.initWith(PrivacySettingOptions.mydepartment, PrivacySettingOptions.mydepartmentDescription)
        privacySettingOptionsArray.append(departmentSettingOption)
        
        let organizationSettingOption = Option.initWith(PrivacySettingOptions.myOrganization, PrivacySettingOptions.myOrganizationDescription)
        privacySettingOptionsArray.append(organizationSettingOption)
        
        let companySettingOption = Option.initWith(PrivacySettingOptions.myCompany, PrivacySettingOptions.myCompanyDescription)
        privacySettingOptionsArray.append(companySettingOption)
        
        let applicationsSettingOption = Option.initWith(PrivacySettingOptions.myApplication, PrivacySettingOptions.myApplicationDescription)
        privacySettingOptionsArray.append(applicationsSettingOption)
        
        let groupSettingOption = Option.initWith(PrivacySettingOptions.myGroup, PrivacySettingOptions.myGroupDescription)
        privacySettingOptionsArray.append(groupSettingOption)
        
        let taskSettingOption = Option.initWith(PrivacySettingOptions.myTask, PrivacySettingOptions.myTaskDescription)
        privacySettingOptionsArray.append(taskSettingOption)
        
        let scheduleSettingOption = Option.initWith(PrivacySettingOptions.mySchedule, PrivacySettingOptions.myScheduleDescription)
        privacySettingOptionsArray.append(scheduleSettingOption)
    }
}
