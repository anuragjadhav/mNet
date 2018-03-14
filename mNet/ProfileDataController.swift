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

}
