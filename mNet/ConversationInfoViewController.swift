//
//  ConversationInfoViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 31/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationInfoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: Outlets and Properties
    @IBOutlet weak var user1Label: CustomBrownTextColorLabel!
    @IBOutlet weak var user2Label: CustomBrownTextColorLabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var membersLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var membersTableView: UITableView!
    
    var dataCtrl:ConversationsDataController?
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
        
        dataCtrl?.setupMemberList()
        
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
        
        dateAndTimeLabel.text = dateTimeString

    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataCtrl?.memberList!.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MembersTableViewCell = tableView.dequeueReusableCell(withIdentifier:"MembersTableViewCell") as! MembersTableViewCell
        
        let member:ConversationMember = (dataCtrl?.memberList![indexPath.row])!
        
        var isPostCreator:Bool?
        
        if(dataCtrl?.selectedCoversation?.postCreator == User.loggedInUser()?.userId)
        {
            isPostCreator = true
        }
        else
        {
            isPostCreator = false
        }
        
        cell.loadCellWithMember(member:member,isPostCreator: isPostCreator!)
        
        return cell
    }
    

    
    //MARK: Button Actions
 
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.membersTableView)
        let indexPath:IndexPath = self.membersTableView.indexPathForRow(at: buttonPoint)!
        
        let memberToDelete:ConversationMember = (dataCtrl?.memberList![indexPath.row])!
        
        dataCtrl?.memberToDelete = memberToDelete
        
        let alert = UIAlertController(title:"Delete", message:"Are you sure to delete this user from conversation?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"No", style:.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title:"Yes", style:.default, handler: { _ in
            self.deleteUser()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Server call to delete user
    
    func deleteUser()
    {
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            
            dataCtrl?.deleteUserFromConversation(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    self.membersTableView.reloadData()
                }
                
            }, onFailure: { [unowned self] (errorMessage) in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    
                    let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        }else{
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
