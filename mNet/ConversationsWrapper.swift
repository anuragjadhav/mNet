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
        
        request(URLS.conversationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseArray { (response: DataResponse<[Conversation]>) in
           
            if let mappedConversationList:[Conversation] = response.result.value {
                
                onSuccess(mappedConversationList)
            }
            else{
                
                onFailure("Unable to fetch conversation list")
            }
        }
    }
}
