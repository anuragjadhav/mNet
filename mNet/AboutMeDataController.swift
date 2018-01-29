//
//  AboutMeDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/28/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class AboutMeDataController: NSObject {

    var profile:Profile?
    
    var editedFirstName : String?
    var editedLastName : String?
    var editedDob : String?
    var editedGender : String?
    var editedPhoneNo : String?
    var editedAddress : String?
    var editedAbout : String?
    var editedDesignation : String?
    var editedMobileNo : String?
    var editedEmailId : String?

    func updateUserDetails(onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){

        //set parameters to post
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = user.toJSON()
        postParams[""] = editedFirstName
        postParams[""] = editedLastName
        postParams[""] = editedPhoneNo
        postParams[""] = editedDesignation
        postParams[""] = editedMobileNo
        postParams[""] = editedAddress
        postParams[""] = editedAbout
        postParams[""] = editedGender
        postParams[""] = editedEmailId

        if(editedDob != nil)
        {
            postParams[""] = editedDob
        }
        else
        {
            editedDob = ""
            postParams[""] = editedDob
        }
        
        WrapperManager.shared.profileWrapper.updateUserProfileWithParams(postParams: postParams, onSuccess: { [unowned self] (displayMessage) in
            
            //update all values in profile object
            self.profile?.firstName = self.editedFirstName
            self.profile?.lastName = self.editedLastName
            self.profile?.phoneNo = self.editedPhoneNo
            self.profile?.designation = self.editedDesignation
            self.profile?.mobileNo = self.editedMobileNo
            self.profile?.address = self.editedAddress
            self.profile?.about = self.editedAbout
            self.profile?.gender = self.editedGender
            self.profile?.dob = self.editedDob
            
            //set edited email id in user defailts
            let user:User  = User.loggedInUser()!
            user.email = self.editedEmailId!
            user.saveToUserDefaults()

            onSuccess(displayMessage)
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
   
}
