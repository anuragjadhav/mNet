//
//  ConversationDetailViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/11/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ConversationDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet weak var sendButton: CustomBlueTextColorButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationTableView.estimatedRowHeight = 66
        conversationTableView.rowHeight = UITableViewAutomaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Keyboard handling
    
    override func keyBoardWillShow(notification: NSNotification) {
        
        super.keyBoardWillShow(notification: notification)
        
         if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
         {
            messageViewBottomConstraint.constant = keyboardSize.height - (self.tabBarController?.tabBar.frame.size.height)!
            self.view.layoutIfNeeded()
         }
    }
    
    override func keyBoardWillHide(notification: NSNotification) {
        
        super.keyBoardWillHide(notification: notification)
        
        messageViewBottomConstraint.constant = 0
        self.view.layoutIfNeeded()

    }
    
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if(indexPath.row == 0 || indexPath.row == 2)
        {
             cell = tableView.dequeueReusableCell(withIdentifier:"SentMessageTableViewCell") as! SentMessageTableViewCell
            
        }
        else
        {
            cell = tableView.dequeueReusableCell(withIdentifier:"ReceivedMessageTableViewCell") as! ReceivedMessageTableViewCell
            
        }
        
        return cell!
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }

    
    // MARK: - Button Actions

    @IBAction func infoButtonAction(_ sender: Any) {
        
        let conversationInfoVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ConversationInfoViewController")
        self.navigationController?.pushViewController(conversationInfoVC, animated: true)
    }
 
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func sendButtonAction(_ sender: Any) {
        
    }


}
