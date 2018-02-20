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
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var user1Label: CustomBrownTextColorLabel!
    @IBOutlet weak var user2Label: UILabel!
    var dataCtrl:ConversationsDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        conversationTableView.estimatedRowHeight = 66
        conversationTableView.rowHeight = UITableViewAutomaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
        
        self.navigationItem.title = dataCtrl?.selectedCoversation?.postTitle
        
        if((dataCtrl?.selectedCoversation?.membersList.count)! > 2)
        {
            let memberCount:Int = (dataCtrl?.selectedCoversation?.membersList.count)!
            
            let member1:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.first)!
            user1Label.text = member1.userName
            
            let member2:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.last)!
            user2Label.text = "\(member2.userName) and \(memberCount - 2)"
        }
        else
        {
            let member1:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.first)!
            user1Label.text = member1.userName
            
            let member2:ConversationMember =  (dataCtrl?.selectedCoversation?.membersList.last)!
            user2Label.text = member2.userName
        }
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let latestReplyDate:Date = dateFormatter.date(from:(dataCtrl?.selectedCoversation?.latestReplierDate)!)!
        
        let dateFormatterToShow : DateFormatter = DateFormatter()
        dateFormatterToShow.dateFormat = "h:mm a yy MMM dd"
        let dateTimeString:String = dateFormatterToShow.string(from: latestReplyDate) + " " + dateFormatterToShow.weekdaySymbols[Calendar.current.component(.weekday, from: latestReplyDate)]
        
        dateTimeLabel.text = dateTimeString
        
        conversationTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: (dataCtrl?.selectedCoversation?.reply.count)! - 1, section: 0)
        self.conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
        
        return (dataCtrl?.selectedCoversation?.reply.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let conversationReply:ConversationReply = (dataCtrl?.selectedCoversation?.reply[indexPath.row])!
        
        var link:String?
        
        if(indexPath.row == (dataCtrl?.selectedCoversation?.reply.count)!-1)
        {
            link = dataCtrl?.selectedCoversation?.postLink
        }
        else
        {
            link = conversationReply.replyLink
        }
        
        let user:User = User.loggedInUser()!
        
        if(user.userId == conversationReply.userId)
        {
           let cell:SentMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SentMessageTableViewCell") as! SentMessageTableViewCell
            
             cell.loadCellWithConversationReply(reply: conversationReply, link: link)
            
            return cell
        }
        else
        {
            let cell:ReceivedMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier:"ReceivedMessageTableViewCell") as! ReceivedMessageTableViewCell
            
            cell.loadCellWithConversationReply(reply: conversationReply, link: link)
            
            return cell
        }        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }

    
    // MARK: - Button Actions

    @IBAction func infoButtonAction(_ sender: Any) {
        
        let conversationInfoVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ConversationInfoViewController") as! ConversationInfoViewController
        conversationInfoVC.dataCtrl = dataCtrl
        self.navigationController?.pushViewController(conversationInfoVC, animated: true)
    }
 
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
  
    @IBAction func sendButtonAction(_ sender: Any) {
        
    }

    @IBAction func uploadButtonAction(_ sender: UIButton) {
        
        let alertController:UIAlertController = UIAlertController(title: "Select Option:", message: nil, preferredStyle: .actionSheet)
        
        alertController.view.tintColor = ColorConstants.kBlueColor
        
        let photos:UIAlertAction = UIAlertAction(title: "Photos and Video Library", style: .default) { (photosAction) in
                self.openDocuments()
        }
        
        let docs:UIAlertAction = UIAlertAction(title: "Document", style: .default) { (docssAction) in
            self.openDocuments()
        }
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(photos)
        alertController.addAction(docs)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func openPhotos() {
        
        
    }
    
    func openDocuments() {
        
        
    }
    

}
