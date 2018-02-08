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
    var selectedCoversation:Conversation?
    var pageStart:Int = 0
    var previousSearchText:String = ""
    var currentSearchText:String = ""
    let pageLength:Int = 10
    var newConversationReply:Conversation?
    var memberList:[ConversationMember]?
    var memberToDelete:ConversationMember?
    
    func getConversations(searchText:String,onSuccess:@escaping (Int) -> Void , onFailure : @escaping (String) -> Void) {
        
        self.currentSearchText = searchText

        //increment page start count only if prevoius search text and latest search text is same
        if(self.previousSearchText == self.currentSearchText && self.currentSearchText != "")
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

            if(self.currentSearchText == self.previousSearchText && self.currentSearchText != "")
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
            
            onSuccess(self.getUnreadConversationCount())
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func markCOnversationAsRead() {
        
        if(self.selectedCoversation?.readState == "0")
        {
            let user:User = User.loggedInUser()!
            var postParams:[String:Any] = [String:Any]()
            postParams["user_id"] = user.userId
            postParams["notification_id"] = selectedCoversation?.postId
            
            WrapperManager.shared.conversationWrapper.markConversationAsRead(postParams: postParams, onSuccess: { [unowned self] in
                
                self.selectedCoversation?.readState = "1"
            }) {
                
            }
        }
    }
    
    func setupMemberList()
    {
        memberList = selectedCoversation?.membersList
    }
    
    func filterMemberListWithSearchTerm(searchTerm:String?)
    {
        if(searchTerm != nil && searchTerm != "")
        {
            let filteredMemberArray:[ConversationMember] = (selectedCoversation?.membersList.filter { $0.userName.contains(searchTerm!) })!
            memberList = filteredMemberArray
        }
        else
        {
            memberList = selectedCoversation?.membersList
        }
    }
    
    func deleteUserFromConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        var postParams:[String:Any] = [String:Any]()
        postParams["UserId"] = memberToDelete?.userId
        postParams["post_id"] = selectedCoversation?.postId
        
        WrapperManager.shared.conversationWrapper.deleteUserFromConversation(postParams: postParams, onSuccess: { [unowned self] in
            
            self.deleteMemberFromList()
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func deleteMemberFromList()
    {
        let newFilteredMemberArray1:[ConversationMember] = (memberList!.filter { $0.userId == memberToDelete?.userId})
        let newFilteredMemberArray2:[ConversationMember] = (selectedCoversation?.membersList.filter { $0.userId == memberToDelete?.userId})!
        
        memberList = newFilteredMemberArray1
        selectedCoversation?.membersList = newFilteredMemberArray2
    }

    
    func getUnreadConversationCount() -> Int
    {
        let filteredArray:[Conversation] =  self.conversations.filter{$0.readState == "0" }
        return filteredArray.count
    }
    
    func postNewConversationMessageReplyWith(message:String)
    {
        
    }
    
    func postNewConversationMediaMessageWithMedia(media:String)
    {
        
    }
    
    
}
