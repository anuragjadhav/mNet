//
//  ConversationsDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationsDataController: NSObject {
    
    var conversations:[Conversation] = []
    var pageStart:Int = 0
    var previousSearchText:String = ""
    var currentSearchText:String = ""
    let pageLength:Int = 10
    
    func getConversations(searchText:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        self.currentSearchText = searchText

        //increment page start count only if prevoius search text and latest search text is same
        if(self.previousSearchText == self.currentSearchText)
        {
            self.pageStart += self.conversations.count
        }
        else
        {
            self.pageStart = 0
        }
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["userId"] = user.userId
        postParams["post_sender_password"] = user.password
        postParams["post_sender_email"] = user.email
        postParams["post_type"] = "0"
        postParams["post_type_id"] = "0"
        postParams["post_start"] = "\(self.pageStart)"
        postParams["post_limit"] = "\(self.pageLength)"
        postParams["search_value"] = self.currentSearchText

        
        WrapperManager.shared.conversationWrapper.getConversationsList(postParams: postParams, onSuccess: { [unowned self] (newConversationList) in

            if(self.currentSearchText == self.previousSearchText)
            {
                //add received new array objects
                for conversation in newConversationList
                {
                    self.conversations.append(conversation)
                }
            }
            else
            {
                self.conversations = newConversationList
            }
            
            self.previousSearchText = self.currentSearchText
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
}
