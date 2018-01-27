//
//  SettingsWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/26/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit


class SettingsWrapper: NSObject {
    
    func getPrivacySettingOfUser(onSuccess:@escaping (PrivacySettings) -> Void , onFailure : @escaping (String) -> Void){
       
        request(URLS.getPrivacySettings).responseObject { (response: DataResponse<PrivacySettings>) in
            
            if let privacySetting:PrivacySettings = response.result.value{
                
                onSuccess(privacySetting)
            }
            else{
                
                onFailure("Unable to fetch privacy settings data")
            }
        }
    }
}
