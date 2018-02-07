//
//  ConversationsWrapper.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationsWrapper: NSObject {
    
    func getConversationsList(postParams:[String:Any], onSuccess:@escaping ([Conversation]) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getConversationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
           
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    let conversationDictArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as! [[String:Any]]
                    let conversationArray:[Conversation] = [Conversation].init(JSONArray: conversationDictArray)
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
