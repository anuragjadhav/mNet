//
//  PeopleDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/31/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PeopleDataController: NSObject {
    
    var peopleArray:[People] = []
    let limit:Int = 20
    var start:Int = 0
    var previousCallSuccessOrFailed:Bool = false
    var showOnlyBlockedUsers:Bool = false

    func getPeopleList(searchText:String,isLoadMore:Bool,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        if(isLoadMore == true)
        {
            self.start += self.peopleArray.count
        }
        else
        {
            self.start = 0
        }
        
        previousCallSuccessOrFailed = false
        
        let user:User = User.loggedInUser()!
        
        var postParams:[String:Any] = user.toJSONPost()
        postParams["UserType"] = searchText
        postParams["limit"] = "\(limit)"
        postParams["start"] = "\(start)"


        WrapperManager.shared.peopleWrapper.getPeopleList(postParams: postParams, onSuccess: { [unowned self] (peopleArray) in
            
            if(self.showOnlyBlockedUsers)
            {
               let filteredBlockedPeopleArray = peopleArray.filter { $0.blockStatus == "Block" }
                
                if(isLoadMore){
                    
                    for people in filteredBlockedPeopleArray
                    {
                        self.peopleArray.append(people)
                    }
                }
                else
                {
                    self.peopleArray = filteredBlockedPeopleArray
                }
            }
            else
            {
                
                if(isLoadMore)
                {
                    for people in peopleArray
                    {
                        self.peopleArray.append(people)
                    }
                }
                else
                {
                    self.peopleArray = peopleArray
                }
            }
            
            self.previousCallSuccessOrFailed = true
            onSuccess()
            
        }) { [unowned self] (errorMessage) in
            self.previousCallSuccessOrFailed = true
            onFailure(errorMessage)
        }
    }
    
}
