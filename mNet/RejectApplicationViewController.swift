//
//  RejectApplicationViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class RejectApplicationViewController: BaseViewController {

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
  
    //MARK: - Button Actions
    @IBAction func rejectButtonAction(_ sender: Any) {
        
        if messageTextView.text.isEmpty || messageTextView.text == "" {
            self.showQuickErrorAlert(message: AlertMessages.enterReplyMessage)
            return
        }
        
        self.showTransperantLoadingOnViewController()
        dataController.rejectPost(replyMessage: messageTextView.text, onSuccess: { (message) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickSuccessAlert(message: message, completion: { (_) in
                    self.approvalsVC?.resetData()
                    self.approvalsVC?.getData()
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
