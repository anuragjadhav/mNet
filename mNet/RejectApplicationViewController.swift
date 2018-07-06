//
//  RejectApplicationViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class RejectApplicationViewController: BaseViewController,UITextViewDelegate {

    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    
    var dataController:ApprovalsDataController = ApprovalsDataController()
    var approvalsVC:ApprovalsViewController?
    
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
  
    //MARK: - Button Actions
    @IBAction func rejectButtonAction(_ sender: Any) {
        
        if messageTextView.text.isEmpty || messageTextView.text == "" {
            self.showQuickErrorAlert(message: AlertMessages.enterReplyMessage)
            return
        }
        
        var type:String = "A"
        switch dataController.selectedSection!.approvalStatus {
        case .verify: type = "I"
        default: type = "A"
        }
        
        self.showTransperantLoadingOnViewController()
        dataController.rejectPost(replyMessage: messageTextView.text, type:type , onSuccess: { (message) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.approvalActionTakenNotification), object: nil, userInfo: nil)
                
                self.showQuickSuccessAlert(message: message, completion: { (_) in
                    
                    if(self.approvalsVC == nil) {
                        self.backTwo()
                    }
                    else{
                        self.navigationController?.popToViewController(self.approvalsVC!, animated: true)
                    }
                })
            }

        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickErrorAlert(message: errorMessage)
            }
        }
    }
    
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
