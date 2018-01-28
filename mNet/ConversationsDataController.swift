//
//  ConversationsDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationsDataController: NSObject {
    
    var conversations:[Conversation] = [Conversation]()
    var pageIndex:Int = 0
    var searchText:String = ""
    let pageLength:Int = 10
    
    func getConversations(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        guard let loggedInUser:User = User.loggedInUser() else {
            return
        }
        
        let conversationsPostData:ConversationsPostObject = ConversationsPostObject()
        conversationsPostData.userId = loggedInUser.userId
        conversationsPostData.userEmail = loggedInUser.email
        conversationsPostData.userPassword = loggedInUser.password
        conversationsPostData.postStart = "\(pageIndex)"
        conversationsPostData.searchValue = searchText
        
        WrapperManager.shared.conversationWrapper.getConversationsList(postObject: conversationsPostData, onSuccess: { [unowned self] (conversationList) in
            
            self.conversations = conversationList
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func incrementPage() {
        
        pageIndex += pageIndex
    }
}
