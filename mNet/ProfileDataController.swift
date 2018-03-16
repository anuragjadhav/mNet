//
//  ProfileDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/28/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ProfileDataController: NSObject {
    
    var profile:Profile?
    var selectedPeople:People?
    
    func getPeopleProfile(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        if(selectedPeople != nil){
            
            var postParams:[String:Any] = [String:Any]()
            postParams["UserId"] = selectedPeople?.userId
            
            WrapperManager.shared.peopleWrapper.getPeopleProfile(postParams: postParams, onSuccess: { [unowned self] (profile) in
                
                self.profile = profile
                onSuccess()
                
            }, onFailure: { (errorMessage) in
                
                onFailure(errorMessage)
            })
        }
    }
    
    func blockUnblockUser(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        if(selectedPeople != nil){
            
            let user:User = User.loggedInUser()!
            var postParams:[String:Any] = [String:Any]()
            postParams["blockUser"] = selectedPeople?.userId
            postParams["userId"] = user.userId
            
            WrapperManager.shared.peopleWrapper.blockUser(postParams: postParams, onSuccess: {
                
                [unowned self] in
                
                if self.selectedPeople?.blockStatus == "Unblock" {
                    self.selectedPeople?.blockStatus = "Block"
                }
                else {
                    self.selectedPeople?.blockStatus = "Unblock"
                }
                
                onSuccess()
                
            }, onFailure: { (errorMessage) in
                
                onFailure(errorMessage)
            })
        }
    }
}
