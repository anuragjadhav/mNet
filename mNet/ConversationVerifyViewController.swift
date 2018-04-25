//
//  ConversationVerifyViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 15/04/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationVerifyViewController: BaseViewController,UITextViewDelegate {

    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    
    var dataCtrl:ConversationsDataController?

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

    @IBAction func verifyButtonAction(_ sender: Any) {
        
        if messageTextView.text.isEmpty || messageTextView.text == "" {
            
            messageTextView.text = "Verified"
        }
        
        self.showTransperantLoadingOnViewController()
        dataCtrl?.verifyConversation(withMessage: messageTextView.text,onSuccess: {
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickSuccessAlert(message:"Verified Successfully", completion: { (_) in
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
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
