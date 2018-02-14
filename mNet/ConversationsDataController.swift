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
    var conversationPageStart:Int = 0
    var previousConversationSearchText:String = ""
    var currentConversationSearchText:String = ""
    let conversationPageLength:Int = 10
    
    var newConversationReply:Conversation?
    
    var memberList:[ConversationMember]? = []
    var memberToDelete:ConversationMember?
    
    var toUserList:[People]? = []
    var bccUserList:[People]? = []
    var forApprovalUserList:[People]? = []
    var forVerificationUserList:[People]? = []
    var selectUserList:[People]? = []
    var selectUserPageStart:Int = 0
    var selectUserPageLength:Int = 10
    var previousSelectUserSearchText:String = ""
    var currentSelectUserSearchText:String = ""
    var selectedFilenameInNewConversation:String?
    var selectedFileDataInNewConversation:Data?
    var newConversationSubject:String?
    var newConversationMessage:String?

    func getConversations(searchText:String,onSuccess:@escaping (Int) -> Void , onFailure : @escaping (String) -> Void) {
        
        self.currentConversationSearchText = searchText

        //increment page start count only if prevoius search text and latest search text is same
        if(self.previousConversationSearchText == self.currentConversationSearchText && self.currentConversationSearchText != "")
        {
            self.conversationPageStart += self.conversations.count
        }
        else
        {
            self.conversationPageStart = 0
        }
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["userId"] = user.userId
        postParams["post_sender_password"] = user.password
        postParams["post_sender_email"] = user.email
        postParams["post_type"] = "0"
        postParams["post_type_id"] = "0"
        postParams["post_start"] = "\(self.conversationPageStart)"
        postParams["post_limit"] = "\(self.conversationPageLength)"
        postParams["search_value"] = self.currentConversationSearchText
        
        WrapperManager.shared.conversationWrapper.getConversationsList(postParams: postParams, onSuccess: { [unowned self] (newConversationList) in

            if(self.currentConversationSearchText == self.previousConversationSearchText && self.currentConversationSearchText != "")
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
            
            self.previousConversationSearchText = self.currentConversationSearchText
            
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
        let newFilteredMemberArray1:[ConversationMember] = (memberList!.filter { $0.userId != memberToDelete?.userId})
        let newFilteredMemberArray2:[ConversationMember] = (selectedCoversation?.membersList.filter { $0.userId != memberToDelete?.userId})!
        
        memberList = newFilteredMemberArray1
        selectedCoversation?.membersList = newFilteredMemberArray2
    }

    
    func getUnreadConversationCount() -> Int
    {
        let filteredArray:[Conversation] =  self.conversations.filter{$0.readState == "0" }
        return filteredArray.count
    }
    

    func getSelectUserList(searchText:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        self.currentSelectUserSearchText = searchText
        
        //increment page start count only if prevoius search text and latest search text is same
        if(self.previousSelectUserSearchText == self.currentSelectUserSearchText && self.currentSelectUserSearchText != "")
        {
            self.selectUserPageStart += (self.selectUserList?.count)!
        }
        else
        {
            self.selectUserPageStart = 0
        }
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["user_id"] = user.userId
        postParams["group_id"] = "1"
        postParams["data_type_id"] = "B2B User"
        postParams["start"] = "\(self.selectUserPageStart)"
        postParams["limit"] = "\(self.selectUserPageLength)"
        postParams["query"] = self.currentSelectUserSearchText
        
        WrapperManager.shared.conversationWrapper.getSelectUserList(postParams: postParams, onSuccess: { [unowned self] (newSelectUserList) in
            
            if(self.currentSelectUserSearchText == self.previousSelectUserSearchText && self.currentSelectUserSearchText != "")
            {
                //add received new array objects
                for user in newSelectUserList
                {
                    self.selectUserList?.append(user)
                }
            }
            else
            {
                self.selectUserList = newSelectUserList
            }
            
            self.previousSelectUserSearchText = self.currentSelectUserSearchText
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func setupSelectedUsersArray()
    {
       bccUserList = selectUserList!.filter { $0.isSelectedForBcc == true}
       toUserList = selectUserList!.filter { $0.isSelectedForTo == true}
       forVerificationUserList = selectUserList!.filter { $0.isSelectedForVerification == true}
       forApprovalUserList = selectUserList!.filter { $0.isSelectedForApproval == true}
    }
    
    
    func refreshPreviouslySelectedData()
    {
        bccUserList = []
        toUserList = []
        forVerificationUserList = []
        forApprovalUserList = []
        selectUserList = []
        selectedFilenameInNewConversation = nil
        selectedFileDataInNewConversation = nil
        newConversationSubject = nil
        newConversationMessage = nil
    }
    
    func getBccSelectedUsersCount() -> Int
    {
        setupSelectedUsersArray()
        return (bccUserList?.count)!
    }
    
    func getToSelectedUsersCount() -> Int
    {
        setupSelectedUsersArray()
        return (toUserList?.count)!
    }
    
    func getVerificationSelectedUsersCount() -> Int
    {
        setupSelectedUsersArray()
        return (forVerificationUserList?.count)!
    }
    
    func getApprovalSelectedUsersCount() -> Int
    {
        setupSelectedUsersArray()
        return (forApprovalUserList?.count)!
    }
    
}
