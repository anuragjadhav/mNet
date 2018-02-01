//
//  ConversationsWrapper.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationsWrapper: NSObject {
    
    func getConversationsList(postObject:ConversationsPostObject, onSuccess:@escaping ([Conversation]) -> Void , onFailure : @escaping (String) -> Void){
        
        let postParams:[String:Any] = postObject.toJSON()
        
        request(URLS.getConversationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
           
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict["error"] as! String
                
                if(error == "0")
                {
                    let conversationDictArray:[[String:Any]] = responseDict["status"] as! [[String:Any]]
                    
                    var conversationArray:[Conversation] = []
                    
                    for conversationDict in conversationDictArray
                    {
                        let conversation:Conversation = Conversation(JSON: conversationDict)!
                        conversationArray.append(conversation)
                    }
                    
                    onSuccess(conversationArray)
                }
                else
                {
                    onFailure("Unable to fetch conversations")
                }
            }
            else{
                
                onFailure("Unable to fetch conversations")
            }
        }
    }
}
