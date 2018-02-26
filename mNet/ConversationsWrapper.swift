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
                    onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversations"))
                }
            }
            else{
                
                onFailure(WrapperManager.shared.getErrorMessage(message: "Unable to fetch conversations"))
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
                    let usersDictionaryArray:[[String:Any]] = responseDict[DictionaryKeys.APIResponse.responseData] as! [[String:Any]]
                    let userListArray:[People] = [People].init(JSONArray: usersDictionaryArray)
                    onSuccess(userListArray)
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
    
    
    func createNewConversation(postParams:[String:Any],fileName:String,fileData:Data,type:String,name:String, onSuccess:@escaping () -> Void , onFailure : @escaping (String) -> Void){
        
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in postParams {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            multipartFormData.append(fileData, withName:name, fileName:fileName, mimeType: type)
            
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
}
