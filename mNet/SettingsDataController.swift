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
    public private(set) var  privacySettingOptionsArray:[SettingOption] = []
    
    var privacySettings:PrivacySettings?

    override init()
    {
        super.init()
        self.setupSettingOptionsArray()
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
        
        privacySettingOptionsArray.removeAll()
        
        let emailSettingOption = SettingOption(PrivacySettingOptions.myEmailID, PrivacySettingOptions.myEmailIDDescription,(privacySettings?.show_email)!)
        privacySettingOptionsArray.append(emailSettingOption)
        
        let addressSettingOption = SettingOption(PrivacySettingOptions.myAddress, PrivacySettingOptions.myAddressDescription,(privacySettings?.show_address)!)
        privacySettingOptionsArray.append(addressSettingOption)
        
        let mobileSettingOption = SettingOption(PrivacySettingOptions.myMobile, PrivacySettingOptions.myMobileDescription,(privacySettings?.show_mobile)!)
        privacySettingOptionsArray.append(mobileSettingOption)
        
        let birthdaySettingOption = SettingOption(PrivacySettingOptions.myBirthday, PrivacySettingOptions.myBirthdayDescription,(privacySettings?.show_dob)!)
        privacySettingOptionsArray.append(birthdaySettingOption)
        
        let designationSettingOption = SettingOption(PrivacySettingOptions.mydesignation, PrivacySettingOptions.mydesignationDescription,(privacySettings?.show_designation)!)
        privacySettingOptionsArray.append(designationSettingOption)
        
        let departmentSettingOption = SettingOption(PrivacySettingOptions.mydepartment, PrivacySettingOptions.mydepartmentDescription,(privacySettings?.show_department)!)
        privacySettingOptionsArray.append(departmentSettingOption)
        
        let organizationSettingOption = SettingOption(PrivacySettingOptions.myOrganization, PrivacySettingOptions.myOrganizationDescription,(privacySettings?.show_org)!)
        privacySettingOptionsArray.append(organizationSettingOption)
        
        let companySettingOption = SettingOption(PrivacySettingOptions.myCompany, PrivacySettingOptions.myCompanyDescription,(privacySettings?.show_company)!)
        privacySettingOptionsArray.append(companySettingOption)
        
        let applicationsSettingOption = SettingOption(PrivacySettingOptions.myApplication, PrivacySettingOptions.myApplicationDescription,(privacySettings?.show_apps)!)
        privacySettingOptionsArray.append(applicationsSettingOption)
        
        let groupSettingOption = SettingOption(PrivacySettingOptions.myGroup, PrivacySettingOptions.myGroupDescription,(privacySettings?.show_group)!)
        privacySettingOptionsArray.append(groupSettingOption)
        
        let taskSettingOption = SettingOption(PrivacySettingOptions.myTask, PrivacySettingOptions.myTaskDescription,(privacySettings?.show_task)!)
        privacySettingOptionsArray.append(taskSettingOption)
        
        let scheduleSettingOption = SettingOption(PrivacySettingOptions.mySchedule, PrivacySettingOptions.myScheduleDescription,(privacySettings?.show_schedule)!)
        privacySettingOptionsArray.append(scheduleSettingOption)
    }
    
    
    func getPrivacySettingOfUser(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        WrapperManager.shared.settingsWrapper.getPrivacySettingOfUser(onSuccess: { [unowned self] (privacySettings) in
            
            self.privacySettings = privacySettings
            
            self.setupPrivacySettingOptionsArray()
            
            onSuccess()
            
        }) { (diaplayMessage) in
            
            onFailure(diaplayMessage)
        }
    }
}
