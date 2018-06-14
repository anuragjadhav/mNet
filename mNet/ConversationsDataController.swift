//
//  ConversationsDataController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

public enum ConversationStatus {
    case approve
    case verify
    case approvalDetails
    case none
}

struct MenuOptions {
    static let hideIgnorPost:String = "Hide/Ignore Post"
    static let viewDetails:String = "View Details"
    static let approve:String = "Approve"
    static let reject:String = "Reject"
    static let verify:String = "Verify"
    static let addUsers:String = "Add Users"
    static let goToapprovalDetails:String = "Approval Details"
}

import UIKit

class ConversationsDataController: NSObject {
    
    var conversations:[Conversation] = []
    var unreadConversationCount:String = "0"
    var selectedCoversation:Conversation?
    var selectedConversationIndex:Int?
    var conversationPageStart:Int = 0
    let conversationPageLength:Int = 10
    var filterString:String?
    var startDate:String = ""
    var endDate:String = ""
    var previousConversationCallSuccessOrFailed:Bool = false
    var previousSelectUserCallSuccessOrFailed:Bool = false
    var newConversationReply:Conversation?
    
    var memberList:[ConversationMember]? = []
    var memberToDelete:ConversationMember?
    
    var toUserList:[People]? = []
    var bccUserList:[People]? = []
    var forApprovalUserList:[People]? = []
    var forVerificationUserList:[People]? = []
    var selectUserList:[People]? = []
    var selectUserPageStart:Int = 0
    var selectUserPageLength:Int = 20
    var selectedFilenameInNewConversation:String?
    var selectedFileDataInNewConversation:Data?
    var newConversationSubject:String?
    var newConversationMessage:String?
    var isDocumentSelected:Bool? = false
    var selectedUserType:String?
    var isNewConversationAdded:Bool? = false

    var selectedFilenameForNewReply:String?
    var selectedFileDataForNewReply:Data?
    var messageForNewReply:String?
    var isDocumentSelectedForNewReply:Bool? = false
    var didComeToAddExtraUsers:Bool = false
    var newUsersAddedToConversation:Bool = false
    
    var selectedNotification:NotificationObject?
    
    var conversationStatus:ConversationStatus?
    
    func getConversations(searchText:String,isLoadMore:Bool,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        self.previousConversationCallSuccessOrFailed = false
        
        if(isLoadMore == true)
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
        postParams["search_value"] = searchText
        
        if filterString != nil {
            postParams["date_filter_key"] = filterString
            
            if filterString == "5" {
                postParams["from_date"] = startDate
                postParams["to_date"] = endDate
            }
        }
        
        WrapperManager.shared.conversationWrapper.getConversationsList(postParams: postParams, onSuccess: { [unowned self] (newConversationList,unreadConversationCount) in

            if(isLoadMore)
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
            
            self.unreadConversationCount = unreadConversationCount
            self.previousConversationCallSuccessOrFailed = true
            
            onSuccess()
            
        }) {[unowned self] (errorMessage) in
            
            self.previousConversationCallSuccessOrFailed = true
            onFailure(errorMessage)
        }
    }
    
    
    func markCOnversationAsRead() {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["user_id"] = user.userId
        postParams["post_id"] = selectedCoversation?.postId
        
        WrapperManager.shared.conversationWrapper.markConversationAsRead(postParams: postParams, onSuccess: { [unowned self] in
            
            self.selectedCoversation?.readState = "1"
        }) {
            
        }
    }
    
    func setupMemberList()
    {
        memberList = selectedCoversation?.membersList
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


    func getSelectUserList(searchText:String,isLoadMore:Bool,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        previousSelectUserCallSuccessOrFailed = false
        
        if(isLoadMore == true)
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
        postParams["query"] = searchText
        
        WrapperManager.shared.conversationWrapper.getSelectUserList(postParams: postParams, onSuccess: { [unowned self] (newSelectUserList) in
            
            if(isLoadMore)
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
            
            //remove existing users from array
            if(self.didComeToAddExtraUsers)
            {
                self.selectUserList = self.removeExistingAddedUsersFromList(array1: self.selectUserList!, array2: (self.selectedCoversation?.membersList)!)
            }
            
            self.filterSelectUsersListBasedOnSelectedUserType()
            
            self.previousSelectUserCallSuccessOrFailed = true

            onSuccess()
            
        }) {[unowned self] (errorMessage) in
            
            self.previousSelectUserCallSuccessOrFailed = true

            onFailure(errorMessage)
        }
    }
    
    func removeExistingAddedUsersFromList(array1:[People],array2:[ConversationMember]) -> [People]
    {
        var newFilteredArray:[People]? = []
        
        for user:People in array1
        {
            var doesContain:Bool? = false
            
            for member:ConversationMember in array2
            {
                if(user.userId == member.userId)
                {
                    doesContain = true
                }
            }
            
            if(doesContain == false)
            {
                newFilteredArray?.append(user)
            }
        }
        
        return newFilteredArray!
    }
    


    func filterSelectUsersListBasedOnSelectedUserType()
    {
        var otherSelectedArray:[People]? = []
        
        if(selectedUserType == NewConversationUserType.bcc)
        {
            for user in toUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in forVerificationUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in forApprovalUserList!
            {
                otherSelectedArray?.append(user)
            }
        }
        else if(selectedUserType == NewConversationUserType.to)
        {
            for user in bccUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in forVerificationUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in forApprovalUserList!
            {
                otherSelectedArray?.append(user)
            }
        }
        else if(selectedUserType == NewConversationUserType.forVerification)
        {
            for user in toUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in bccUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in forApprovalUserList!
            {
                otherSelectedArray?.append(user)
            }
        }
        else if(selectedUserType == NewConversationUserType.forApproval)
        {
            for user in toUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in forVerificationUserList!
            {
                otherSelectedArray?.append(user)
            }
            
            for user in bccUserList!
            {
                otherSelectedArray?.append(user)
            }
        }
        
        var newFilteredArray:[People]? = []
        
        for user1:People in selectUserList!
        {
            var doesContain:Bool? = false
            
            for user2:People in otherSelectedArray!
            {
                 if(user1.userId == user2.userId)
                 {
                    doesContain = true
                 }
            }
            
            if(doesContain == false)
            {
                newFilteredArray?.append(user1)
            }
        }
        
        selectUserList = newFilteredArray
    }
    
    func doesUserContainInSelectedList(selectedType:String,user:People) -> Bool
    {
        var checkArray:[People]?
        
        if(selectedType == NewConversationUserType.bcc)
        {
            checkArray = bccUserList!
        }
        else if(selectedType == NewConversationUserType.to)
        {
            checkArray = toUserList!
        }
        else if(selectedType == NewConversationUserType.forVerification)
        {
            checkArray = forVerificationUserList!

        }
        else if(selectedType == NewConversationUserType.forApproval)
        {
            checkArray = forApprovalUserList!
        }
        
        let filteredArray = checkArray?.filter{$0.userId == user.userId}
        
        return filteredArray?.count == 0 ? false : true
    }
    
    func insertUserInSelectedList(selectedType:String,user:People)
    {
        if(selectedType == NewConversationUserType.bcc)
        {
            bccUserList?.append(user)
        }
        else if(selectedType == NewConversationUserType.to)
        {
            toUserList?.append(user)
        }
        else if(selectedType == NewConversationUserType.forVerification)
        {
            forVerificationUserList?.append(user)

        }
        else if(selectedType == NewConversationUserType.forApproval)
        {
            forApprovalUserList?.append(user)
        }
    }
    
    func removeUserFromSelectedList(selectedType:String,user:People)
    {
        if(selectedType == NewConversationUserType.bcc)
        {
            var i:Int = 0
            
            for people in bccUserList!
            {
                if(people.userId == user.userId)
                {
                    bccUserList!.remove(at: i)
                    break
                }
                i = i + 1
            }
        }
        else if(selectedType == NewConversationUserType.to)
        {
            var i:Int = 0
            
            for people in toUserList!
            {
                if(people.userId == user.userId)
                {
                    toUserList!.remove(at: i)
                    break
                }
                i = i + 1
            }
        }
        else if(selectedType == NewConversationUserType.forVerification)
        {
            var i:Int = 0
            
            for people in forVerificationUserList!
            {
                if(people.userId == user.userId)
                {
                    forVerificationUserList!.remove(at: i)
                    break
                }
                i = i + 1
            }
            
        }
        else if(selectedType == NewConversationUserType.forApproval)
        {
            var i:Int = 0
            
            for people in forApprovalUserList!
            {
                if(people.userId == user.userId)
                {
                    forApprovalUserList!.remove(at: i)
                    break
                }
                i = i + 1
            }
        }
        
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
    
    
    func createNewConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["sender_id"] = user.userId
        postParams["sender_password"] = user.password
        postParams["sender_email"] = user.email
        postParams["post_type"] = "4"
        postParams["post_type_id"] = "0"
        postParams["post_title"] = newConversationSubject
        postParams["post_message"] = newConversationMessage
        
        var mimeType:String?
        
        //select file parameters
        if(isDocumentSelected == true)
        {
            mimeType = "application/pdf"
        }
        else
        {
            mimeType = "image/jpeg"
        }

        //add bcc to verification and approval emails
        var toEmailArray:[String]? = []
        var bccEmailArray:[String]? = []
        var verificationEmailArray:[String]? = []
        var approvalEmailArray:[String]? = []
        
        //add all emails except bcc in to email
        for user:People in toUserList!
        {
            if(user.email != nil){
                toEmailArray?.append(user.email!)
            }
        }
        
        for user:People in forVerificationUserList!
        {
            if(user.email != nil){
                toEmailArray?.append(user.email!)
            }
        }
        
        for user:People in forApprovalUserList!
        {
            if(user.email != nil){
                toEmailArray?.append(user.email!)
            }
        }
        
        //add bcc emails
        for user:People in bccUserList!
        {
            if(user.email != nil){
                bccEmailArray?.append(user.email!)
            }
        }
        
        //add verification emails
        for user:People in forVerificationUserList!
        {
            if(user.email != nil){
                verificationEmailArray?.append(user.email!)
            }
        }
        
        //add approval emails
        for user:People in forApprovalUserList!
        {
            if(user.email != nil){
                approvalEmailArray?.append(user.email!)
            }
        }
        
        postParams["to_id"] = toEmailArray?.joined(separator: ",")
        postParams["bcc_id"] = bccEmailArray?.joined(separator: ",")
        postParams["agree_id"] = verificationEmailArray?.joined(separator: ",")
        postParams["approve"] = approvalEmailArray?.joined(separator: ",")
        
        WrapperManager.shared.conversationWrapper.createNewConversation(postParams: postParams, fileName:selectedFilenameInNewConversation , fileData: selectedFileDataInNewConversation, type: mimeType, name:"file_name", onSuccess: {
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func setNewReplyWithoutDocumentConversation(replyMessage:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_sender_id"] = user.userId
        postParams["reply_sender_password"] = user.password
        postParams["reply_sender_email"] = user.email
        postParams["reply_type"] = "0"
        postParams["reply_message"] = replyMessage
        postParams["post_id"] = selectedCoversation?.postId
        
        WrapperManager.shared.conversationWrapper.setNewReplyConversation(postParams: postParams, fileName: nil, fileData: nil, type: nil, name: nil, onSuccess: { [unowned self] (replyId,replyLink) in
            
            let conversationReply:ConversationReply = ConversationReply(JSON: [String : Any]())!
            
            let user:User = User.loggedInUser()!
            conversationReply.userId = user.userId
            conversationReply.replyMessage = replyMessage
            conversationReply.replyId = replyId
            conversationReply.replyLink = replyLink
            conversationReply.fullName = user.name
            
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let createdOnDateString = dateFormatter.string(from: Date())
            conversationReply.createdOn = createdOnDateString
            
            self.selectedCoversation?.reply.append(conversationReply)
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }

    }
    
    func setNewReplyWithDocumentConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_sender_id"] = user.userId
        postParams["reply_sender_password"] = user.password
        postParams["reply_sender_email"] = user.email
        postParams["reply_type"] = "0"
        postParams["reply_message"] = messageForNewReply
        postParams["post_id"] = selectedCoversation?.postId
        
        var mimeType:String?
        
        //select file parameters
        if(isDocumentSelectedForNewReply == true)
        {
            mimeType = "application/pdf"
        }
        else
        {
            mimeType = "image/jpeg"
        }
        
        WrapperManager.shared.conversationWrapper.setNewReplyConversation(postParams: postParams, fileName: selectedFilenameForNewReply, fileData: selectedFileDataForNewReply, type: mimeType, name:"document", onSuccess: { [unowned self] (replyId,replyLink) in
            
            let conversationReply:ConversationReply = ConversationReply(JSON: [String : Any]())!
            
            let user:User = User.loggedInUser()!
            conversationReply.userId = user.userId
            conversationReply.replyMessage = self.messageForNewReply ?? ""
            conversationReply.replyId = replyId
            conversationReply.replyLink = replyLink
            conversationReply.fullName = user.name
            
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let createdOnDateString = dateFormatter.string(from: Date())
            conversationReply.createdOn = createdOnDateString
            
            self.selectedCoversation?.reply.append(conversationReply)
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func deleteConversationReply(reply:ConversationReply,Atindex:Int,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_id"] = reply.replyId

        WrapperManager.shared.conversationWrapper.deleteConversationReply(postParams: postParams, onSuccess: { [unowned self]  in
            
            self.selectedCoversation?.reply.remove(at: Atindex)
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func hideConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["user_id"] = user.userId
        postParams["post_id"] = selectedCoversation?.postId
        
        WrapperManager.shared.conversationWrapper.hideConversation(postParams: postParams, onSuccess: { [unowned self]  in
            
             self.conversations.remove(at: self.selectedConversationIndex!)
            onSuccess()

            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func ignoreConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void)  {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["user_id"] = user.userId
        postParams["post_id"] = selectedCoversation?.postId
        
        WrapperManager.shared.conversationWrapper.ignoreConversation(postParams: postParams, onSuccess: { [unowned self]  in
            
            self.conversations.remove(at: self.selectedConversationIndex!)
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func addUsersToSelectedConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["sender_id"] = user.userId
        postParams["sender_password"] = user.password
        postParams["sender_email"] = user.email
        postParams["post_id"] = selectedCoversation?.postId

        //add bcc to verification and approval emails
        var toEmailArray:[String]? = []
        var bccEmailArray:[String]? = []
        var verificationEmailArray:[String]? = []
        var approvalEmailArray:[String]? = []
        
        //add all emails except bcc in to email
        for user:People in toUserList!
        {
            if(user.email != nil){
                toEmailArray?.append(user.email!)
            }
        }
        
        for user:People in forVerificationUserList!
        {
            if(user.email != nil){
                toEmailArray?.append(user.email!)
            }
        }
        
        for user:People in forApprovalUserList!
        {
            if(user.email != nil){
                toEmailArray?.append(user.email!)
            }
        }
        
        //add bcc emails
        for user:People in bccUserList!
        {
            if(user.email != nil){
                bccEmailArray?.append(user.email!)
            }
        }
        
        //add verification emails
        for user:People in forVerificationUserList!
        {
            if(user.email != nil){
                verificationEmailArray?.append(user.email!)
            }
        }
        
        //add approval emails
        for user:People in forApprovalUserList!
        {
            if(user.email != nil){
                approvalEmailArray?.append(user.email!)
            }
        }
        
        postParams["addusers"] = toEmailArray?.joined(separator: ";")
        postParams["addusersasbcc"] = bccEmailArray?.joined(separator: ";")
        postParams["addusersasagree"] = verificationEmailArray?.joined(separator: ";")
        postParams["addusersasapprove"] = approvalEmailArray?.joined(separator: ";")
        
        WrapperManager.shared.conversationWrapper.addUsersToConversation(postParams: postParams, onSuccess: {
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    
    func getConversation(onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["userId"] = user.userId
        postParams["post_sender_password"] = user.password
        postParams["post_sender_email"] = user.email
        postParams["post_type"] = "0"
        postParams["post_type_id"] = "0"
        postParams["post_id"] = selectedNotification?.postId

        WrapperManager.shared.conversationWrapper.getConversation(postParams: postParams, onSuccess: { [unowned self] (conversation) in
            
            self.selectedCoversation = conversation
            self.checkWhetherSelectedConversationIsVerifyOrApprove()
            
            onSuccess()
            
        }) {(errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func getPopoverObjectsFromStringArray(stringArray:[String]?) -> [PopoverObject]
    {
        var popOverObjectArray:[PopoverObject] = [PopoverObject]()
        
        for titleString in stringArray ?? []
        {
            let popOverObject:PopoverObject = PopoverObject()
            popOverObject.title = titleString
            popOverObjectArray.append(popOverObject)
        }
        
        return popOverObjectArray
    }
    
    func checkWhetherSelectedConversationIsVerifyOrApprove()
    {
        if(selectedCoversation?.approvalType == nil || selectedCoversation?.approvalType == "")
        {
            for member in (selectedCoversation?.membersList)!
            {
                if(member.userId == User.loggedInUser()?.userId)
                {
                    if (member.askForAgree == "Yes" && member.agreeStatus == "Pending")
                    {
                        conversationStatus = .verify
                    }
                    else if (member.askForApprove == "Yes" && member.agreeStatus == "Pending")
                    {
                        conversationStatus = .approve
                    }
                    else
                    {
                        conversationStatus = .none
                    }
                    
                    break
                }
            }
        }
        else if (selectedCoversation?.approvalType != nil && (selectedCoversation?.approvalType == "I" || selectedCoversation?.approvalType == "A"))
        {
            conversationStatus = .approvalDetails
        }
    }
    
    func getPopoverObjectsForMenu() -> [PopoverObject]
    {
        var popOverObjectArray = [PopoverObject]()
        
        let infoPopOverObject:PopoverObject = PopoverObject()
        infoPopOverObject.title = MenuOptions.viewDetails
        infoPopOverObject.image = UIImage(named: "infoIcon")
        popOverObjectArray.append(infoPopOverObject)

//        let hideIgnorePopOverObject:PopoverObject = PopoverObject()
//        hideIgnorePopOverObject.title = MenuOptions.hideIgnorPost
//        hideIgnorePopOverObject.image = UIImage(named: "hideIcon")
//        popOverObjectArray.append(hideIgnorePopOverObject)
        
//        let forwardToUsersPopOverObject:PopoverObject = PopoverObject()
//        forwardToUsersPopOverObject.title = MenuOptions.addUsers
//        forwardToUsersPopOverObject.image = UIImage(named: "forward")
//        popOverObjectArray.append(forwardToUsersPopOverObject)

        switch conversationStatus {
            
        case .approve? :
            
            let approvePopOverObject:PopoverObject = PopoverObject()
            approvePopOverObject.title = MenuOptions.approve
            approvePopOverObject.image = UIImage(named: "greenTick")
            popOverObjectArray.append(approvePopOverObject)
            
            let rejectPopOverObject:PopoverObject = PopoverObject()
            rejectPopOverObject.title = MenuOptions.reject
            rejectPopOverObject.image = UIImage(named: "redCross")
            popOverObjectArray.append(rejectPopOverObject)
            
            break
            
        case .verify? :
            
            let verifyPopOverObject:PopoverObject = PopoverObject()
            verifyPopOverObject.title = MenuOptions.verify
            verifyPopOverObject.image = UIImage(named: "greenTick")
            popOverObjectArray.append(verifyPopOverObject)
            
            let rejectPopOverObject:PopoverObject = PopoverObject()
            rejectPopOverObject.title = MenuOptions.reject
            rejectPopOverObject.image = UIImage(named: "redCross")
            popOverObjectArray.append(rejectPopOverObject)
            
            break
            
        case .approvalDetails? :
            
            let detailsPopOverObject:PopoverObject = PopoverObject()
            detailsPopOverObject.title = MenuOptions.goToapprovalDetails
            detailsPopOverObject.image = UIImage(named: "rightArrow")
            popOverObjectArray.append(detailsPopOverObject)
            
            break
            
        default:
            break
        }

        return popOverObjectArray

    }
    
    
    func rejectApprovalConversation(withMessage:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_sender_id"] = user.userId
        postParams["reply_sender_password"] = user.password
        postParams["post_id"] = selectedCoversation?.postId
        postParams["reply_message"] = withMessage
        postParams["reply_type"] = "2"
        postParams["activity_type"] = "reject"
        
       WrapperManager.shared.conversationWrapper.setApprovalRejectionReplyOnConversation(postParams: postParams, onSuccess: { [unowned self] in
        
        self.conversationStatus = .none
        
          onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func rejectVerificationConversation(withMessage:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_sender_id"] = user.userId
        postParams["reply_sender_password"] = user.password
        postParams["post_id"] = selectedCoversation?.postId
        postParams["reply_message"] = withMessage
        postParams["reply_type"] = "1"
        postParams["activity_type"] = "disagree"
        
        WrapperManager.shared.conversationWrapper.setApprovalRejectionReplyOnConversation(postParams: postParams, onSuccess: { [unowned self] in
            
            self.conversationStatus = .none
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func verifyConversation(withMessage:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_sender_id"] = user.userId
        postParams["reply_sender_password"] = user.password
        postParams["post_id"] = selectedCoversation?.postId
        postParams["reply_message"] = withMessage
        postParams["reply_type"] = "1"
        postParams["activity_type"] = "agree"
        
    WrapperManager.shared.conversationWrapper.setApprovalRejectionReplyOnConversation(postParams: postParams, onSuccess: {  [unowned self] in
            
            self.conversationStatus = .none
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
    func approveConversation(withMessage:String,onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void) {
        
        let user:User = User.loggedInUser()!
        var postParams:[String:Any] = [String:Any]()
        postParams["reply_sender_id"] = user.userId
        postParams["reply_sender_password"] = user.password
        postParams["post_id"] = selectedCoversation?.postId
        postParams["reply_message"] = withMessage
        postParams["reply_type"] = "2"
        postParams["activity_type"] = "approve"
        
        WrapperManager.shared.conversationWrapper.setApprovalRejectionReplyOnConversation(postParams: postParams, onSuccess: {  [unowned self] in
            
            self.conversationStatus = .none
            
            onSuccess()
            
        }) { (errorMessage) in
            
            onFailure(errorMessage)
        }
    }
    
}
