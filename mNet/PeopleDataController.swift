//
//  PeopleDataController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/31/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PeopleDataController: NSObject {
    
    private var originalPeopleListArray:[People] = []
    var peopleArray:[People] = []
    let limit:Int = 100
    var start:Int = 0
    var previousCallSuccessOrFailed:Bool = false
    var showOnlyBlockedUsers:Bool = false

    func getPeopleList(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        previousCallSuccessOrFailed = false
        
        let user:User = User.loggedInUser()!
        
        var postParams:[String:Any] = user.toJSONPost()
        postParams["UserType"] = ""
        postParams["limit"] = "\(limit)"
        postParams["start"] = "\(start)"

        WrapperManager.shared.peopleWrapper.getPeopleList(postParams: postParams, onSuccess: { [unowned self] (peopleArray) in
            
            var filteredBlockedPeopleArray:[People] = []
            
            if(self.showOnlyBlockedUsers)
            {
                filteredBlockedPeopleArray = peopleArray.filter { $0.blockStatus == "Block" }
            }
            else
            {
                filteredBlockedPeopleArray = peopleArray
            }
            
            for people in filteredBlockedPeopleArray
            {
                self.originalPeopleListArray.append(people)
            }
            
            self.peopleArray = self.originalPeopleListArray
            
            //change start
            self.start += self.originalPeopleListArray.count
            self.previousCallSuccessOrFailed = true
            onSuccess()
            
        }) { [unowned self] (errorMessage) in
            self.previousCallSuccessOrFailed = true
            onFailure(errorMessage)
        }
    }
    
    func filterPeopleWithSearchTerm(searchTerm:String?)
    {
        if(searchTerm != nil && searchTerm != "")
        {
            let filteredPeopleArray:[People] = originalPeopleListArray.filter { $0.userName!.localizedCaseInsensitiveContains(searchTerm!) }
            self.peopleArray = filteredPeopleArray
        }
        else
        {
            self.peopleArray = self.originalPeopleListArray
        }
    }
}
