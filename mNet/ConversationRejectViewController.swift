//
//  ConversationRejectViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 15/04/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationRejectViewController: BaseViewController,UITextViewDelegate {
    
    @IBOutlet weak var messageTextView: CustomBrownColorTextView!

    var dataCtrl:ConversationsDataController?
    var conversationStatus:ConversationStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }
   
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Text View Delegates
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n"){
            
            self.view.endEditing(true)
        }
        
        return true
    }
    

    // MARK: - Button Action
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func rejectButtonAction(_ sender: Any) {
        
        switch self.dataCtrl?.conversationStatus {
            
        case .approve? :
            
            approveReject()
            
            break
            
        case .verify? :
            
            verifyReject()
            
            break
            
        default :
            break
            
        }
        
    }
    
    func verifyReject()
    {
        if messageTextView.text.isEmpty || messageTextView.text == "" {
            self.showQuickErrorAlert(message: AlertMessages.enterReplyMessage)
            return
        }
        
        self.showTransperantLoadingOnViewController()
        dataCtrl?.rejectVerificationConversation(withMessage: messageTextView.text,onSuccess: {
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickSuccessAlert(message:"Document Rejected", completion: { (_) in
                    self.navigationController?.popViewController(animated: true)
                })
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickErrorAlert(message: errorMessage)
            }
        }
    }
    
    func approveReject()
    {
        if messageTextView.text.isEmpty || messageTextView.text == "" {
            self.showQuickErrorAlert(message: AlertMessages.enterReplyMessage)
            return
        }
        
        self.showTransperantLoadingOnViewController()
        dataCtrl?.rejectApprovalConversation(withMessage: messageTextView.text,onSuccess: {
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickSuccessAlert(message:"Document Rejected", completion: { (_) in
                    self.navigationController?.popViewController(animated: true)
                })
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickErrorAlert(message: errorMessage)
            }
        }
    }

}
