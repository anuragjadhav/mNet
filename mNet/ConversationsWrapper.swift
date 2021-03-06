//
//  ConversationsWrapper.swift
//  mNet
//
//  Created by Nachiket Vaidya on 28/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//


import UIKit

class ConversationsWrapper: NSObject {
    
    func getConversationsList(postParams:[String:Any], onSuccess:@escaping ([Conversation],String) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getConversationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
           
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let conversationDictArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:Any]] else {
                        let unreadNotifiactionCount:String = (responseDict["unread_post_count"] ?? "0") as! String
                        onSuccess([Conversation](),unreadNotifiactionCount)
                        return
                    }
                    let conversationArray:[Conversation] = [Conversation].init(JSONArray: conversationDictArray)
                    let unreadNotifiactionCount = responseDict["unread_post_count"] ?? "0"
                    let filteredConversationArray = conversationArray.filter{$0.ignore == "0"}
                    onSuccess(filteredConversationArray,unreadNotifiactionCount as! String)
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversations"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversations"))
            }
        }
    }
    
    func getConversation(postParams:[String:Any], onSuccess:@escaping (Conversation) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getConversationsList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let conversationDict:[String:Any] = responseDict[DictionaryKeys.APIResponse.responseData] as? [String:Any] else {
                        onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversation"))
                        return
                    }
                    let conversation:Conversation = Conversation(JSON:conversationDict)!
                    onSuccess(conversation)
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversation"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversation"))
            }
        }
    }
    
    
    
    func markConversationAsRead(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping () -> Void){
        
        request(URLS.markConversationAsRead, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure()
                }
            }
            else{
                
                onFailure()
            }
        }
    }
    
    func deleteUserFromConversation(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.deleteUserFromConversation, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure("Unable to delete user")
                }
            }
            else{
                
                onFailure("Unable to delete user")
            }
        }
    }
    
    func getSelectUserList(postParams:[String:Any], onSuccess:@escaping ([People]) -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.getSelectUserList, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    guard let usersDictionaryArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as? [[String:Any]] else {
                        onSuccess([People]())
                        return
                    }
                    let userListArray:[People] = [People].init(JSONArray: usersDictionaryArray)
                    onSuccess(userListArray)
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure("Unable to fetch users")
                }
            }
            else{
                
                onFailure("Unable to fetch users")
            }
        }
    }
    
    
    func createNewConversation(postParams:[String:Any],fileName:String?,fileData:Data?,type:String?,name:String?, onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in postParams {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if(fileName != nil && fileData != nil && type != nil && name != nil){
                multipartFormData.append(fileData!, withName:name!, fileName:fileName!, mimeType: type!)
            }
            
        
        }, usingThreshold: UInt64.init(), to: URLS.createNewConversation, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                        
                        let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                        
                        if(error == DictionaryKeys.APIResponse.noError)
                        {
                            onSuccess()
                        }
                        else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                        {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                            return
                        }
                        else
                        {
                            onFailure("Unable to upload file")
                        }
                    }
                    else{
                        
                        onFailure("Unable to upload file")
                    }
                }
            case .failure(_):
              
                 onFailure("Unable to upload file")
            }
        }
    }
    
    func setNewReplyConversation(postParams:[String:Any],fileName:String?,fileData:Data?,type:String?,name:String?, onSuccess:@escaping (String,String) -> Void , onFailure : @escaping (String) -> Void){
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in postParams {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if(fileName != nil && fileData != nil && type != nil && name != nil)
            {
                multipartFormData.append(fileData!, withName:name!, fileName:fileName!, mimeType: type!)
            }
        
        }, usingThreshold: UInt64.init(), to: URLS.setNewReplyConversation, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    if var responseDict:[String:Any] = response.result.value as? [String:Any] {
                        
                        let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                        
                        if(error == DictionaryKeys.APIResponse.noError)
                        {
                        
                            onSuccess(responseDict["reply_id"] as! String,responseDict["reply_link"] as! String)
                        }
                        else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                        {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                            return
                        }
                        else
                        {
                            onFailure("Unable to send reply")
                        }
                    }
                    else{
                        
                        onFailure("Unable to send reply")
                    }
                }
            case .failure(_):
                
                onFailure("Unable to send reply")
            }
        }
    }
    
    
    func deleteConversationReply(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.deleteConversationReply, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else if(error == DictionaryKeys.APIResponse.invaidCredentialsError)
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.invalidCredentialsNotification), object: nil, userInfo: nil)
                    return
                }
                else
                {
                    onFailure("Unable to delete reply")
                }
            }
            else{
                
                onFailure("Unable to delete reply")
            }
        }
    }
    
    
    func hideConversation(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.hideConversation, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else
                {
                    onFailure("Unable to hide conversation")
                }
            }
            else{
                
                onFailure("Unable to hide conversation")
            }
        }
    }
    
    
    func ignoreConversation(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.ignoreConversation, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else
                {
                    onFailure("Unable to ignore conversation")
                }
            }
            else{
                
                onFailure("Unable to ignore conversation")
            }
        }
    }
    
    func addUsersToConversation(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        request(URLS.addUsersToExistingConversation, method: .post, parameters: postParams, encoding: JSONEncoding() as ParameterEncoding, headers: nil).responseJSON { response in
            
            if let responseDict:[String:Any] = response.result.value as? [String:Any] {
                
                var error:String?
                
                do
                {
                   error = responseDict[DictionaryKeys.APIResponse.error] as? String
                    
                  guard error != nil
                  else
                  {
                    throw ResultError.InvalidFormat
                  }
                    
                }
                catch{
                    
                    onFailure("Unable to add users in this conversation")
                }
                
                if(error == DictionaryKeys.APIResponse.noError)
                {
                    onSuccess()
                }
                else
                {
                    onFailure("Unable to add users in this conversation")
                }
            }
            else{
                
                onFailure("Unable to add users in this conversation")
            }
        }
    }
    
    
      func setApprovalRejectionReplyOnConversation(postParams:[String:Any], onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in postParams {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
        }, usingThreshold: UInt64.init(), to: URLS.setNewReplyConversation, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    
                    if var responseDict:[String:Any] = response.result.value as? [String:Any] {
                        
                        let error:String = responseDict[DictionaryKeys.APIResponse.error] as! String
                        
                        if(error == DictionaryKeys.APIResponse.noError)
                        {
                            
                            onSuccess()
                        }
                        else
                        {
                            onFailure("Unable to perform action")
                        }
                    }
                    else{
                        
                        onFailure("Unable to perform action")
                    }
                }
            case .failure(_):
                
                onFailure("Unable to perform action")
            }
        }
    }
    
}
