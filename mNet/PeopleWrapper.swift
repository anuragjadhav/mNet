//
//  PeopleWrapper.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/31/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PeopleWrapper: NSObject {
    
    func getPeopleList(postParams:[String:Any], onSuccess:@escaping ([People]) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getPeopleList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict["error"] as! String
                
                if(error == "0")
                {
                    let peopleDictArray:[[String:Any]] = responseDict["status"] as! [[String:Any]]
                    
                    var peopleArray:[People] = []
                    
                    for peopleDict in peopleDictArray
                    {
                        let people:People = People(JSON: peopleDict)!
                        peopleArray.append(people)
                    }
                    
                    onSuccess(peopleArray)
                }
                else
                {
                    onFailure("Unable to fetch people list")
                }
            }
            else{
                
                onFailure("Unable to fetch people list")
            }
        }
    }
}
