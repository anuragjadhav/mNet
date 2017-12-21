//
//  PrivacySettingsDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PrivacySettingsDataController: NSObject {
    
    public private(set) var  optionsArray:[Option] = []
    
    override init()
    {
        super.init()
        self.setupOptionsArray()
    }
    
    private func setupOptionsArray() {
        
        let emailSettingOption = Option.initWith(PrivacySettingOptions.myEmailID, PrivacySettingOptions.myEmailIDDescription)
        optionsArray.append(emailSettingOption)
        
        let addressSettingOption = Option.initWith(PrivacySettingOptions.myAddress, PrivacySettingOptions.myAddressDescription)
        optionsArray.append(addressSettingOption)
        
        let mobileSettingOption = Option.initWith(PrivacySettingOptions.myMobile, PrivacySettingOptions.myMobileDescription)
        optionsArray.append(mobileSettingOption)
        
        let birthdaySettingOption = Option.initWith(PrivacySettingOptions.myBirthday, PrivacySettingOptions.myBirthdayDescription)
        optionsArray.append(birthdaySettingOption)
        
        let designationSettingOption = Option.initWith(PrivacySettingOptions.mydesignation, PrivacySettingOptions.mydesignationDescription)
        optionsArray.append(designationSettingOption)
        
        let departmentSettingOption = Option.initWith(PrivacySettingOptions.mydepartment, PrivacySettingOptions.mydepartmentDescription)
        optionsArray.append(departmentSettingOption)
        
        let organizationSettingOption = Option.initWith(PrivacySettingOptions.myOrganization, PrivacySettingOptions.myOrganizationDescription)
        optionsArray.append(organizationSettingOption)
        
        let companySettingOption = Option.initWith(PrivacySettingOptions.myCompany, PrivacySettingOptions.myCompanyDescription)
        optionsArray.append(companySettingOption)
        
        let applicationsSettingOption = Option.initWith(PrivacySettingOptions.myApplication, PrivacySettingOptions.myApplicationDescription)
        optionsArray.append(applicationsSettingOption)
        
        let groupSettingOption = Option.initWith(PrivacySettingOptions.myGroup, PrivacySettingOptions.myGroupDescription)
        optionsArray.append(groupSettingOption)
        
        let taskSettingOption = Option.initWith(PrivacySettingOptions.myTask, PrivacySettingOptions.myTaskDescription)
        optionsArray.append(taskSettingOption)
        
        let scheduleSettingOption = Option.initWith(PrivacySettingOptions.mySchedule, PrivacySettingOptions.myScheduleDescription)
        optionsArray.append(scheduleSettingOption)
    }

}
