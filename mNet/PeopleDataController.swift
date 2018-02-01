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
    let limit:Int = 15
    var start:Int = 0
    
    func getPeopleList(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        
        var postParams:[String:Any] = user.toJSON()
        postParams["UserType"] = ""
        postParams["limit"] = "\(limit)"
        postParams["start"] = "\(start)"

        WrapperManager.shared.peopleWrapper.getPeopleList(postParams: postParams, onSuccess: { [unowned self] (peopleArray) in
            
            for people in peopleArray
            {
                self.originalPeopleListArray.append(people)
            }
            
            self.peopleArray = self.originalPeopleListArray
            
            //change start
            self.start += self.originalPeopleListArray.count
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func filterPeopleWithSearchTerm(searchTerm:String?)
    {
        if(searchTerm != nil && searchTerm != "")
        {
            let filteredPeopleArray:[People] = originalPeopleListArray.filter { $0.userName!.contains(searchTerm!) }
            self.peopleArray = filteredPeopleArray
        }
        else
        {
            self.peopleArray = self.originalPeopleListArray
        }
    }
}
