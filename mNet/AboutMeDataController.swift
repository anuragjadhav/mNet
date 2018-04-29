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

    func updateUserDetails(onSuccess:@escaping (String) -> Void , onFailure : @escaping (String) -> Void){

        //set parameters to post
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["user_id"] = user.userId
        postParams["password"] = user.password
        postParams["user_first_name"] = editedFirstName
        postParams["user_last_name"] = editedLastName
        postParams["user_phone"] = editedPhoneNo
        postParams["user_designation"] = editedDesignation
        postParams["user_mobile"] = editedMobileNo
        postParams["user_address"] = editedAddress
        postParams["user_about"] = editedAbout
        postParams["user_gender"] = editedGender

        if(editedDob != nil)
        {
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            guard let selectedDate:Date = dateFormatter.date(from: (editedDob)!)
                else {return}
            dateFormatter.dateFormat = "yyyy-MM-dd"
            postParams["user_dob"] = dateFormatter.string(from: selectedDate)
        }
        else
        {
            editedDob = ""
            postParams["user_dob"] = editedDob
        }
        
        WrapperManager.shared.profileWrapper.updateUserProfileWithParams(postParams: postParams, onSuccess: {  displayMessage in
            
            onSuccess(displayMessage)
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
   
}
