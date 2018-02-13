//
//  NewConversationViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class NewConversationViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var subjectTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    @IBOutlet weak var attachmentNameLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var selectedToUsersCollectionView: UICollectionView!
    @IBOutlet weak var selectedForVerificationUsersCollectionView: UICollectionView!
    @IBOutlet weak var selectedForApprovalUsersCollectionView: UICollectionView!
    @IBOutlet weak var selectedBccUsersCollectionView: UICollectionView!

    var dataCtrl:ConversationsDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
        
        selectedToUsersCollectionView.reloadData()
        selectedBccUsersCollectionView.reloadData()
        selectedForVerificationUsersCollectionView.reloadData()
        selectedForApprovalUsersCollectionView.reloadData()
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Collection view delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView === selectedToUsersCollectionView)
        {
            return (dataCtrl?.toUserList!.count)!
        }
        else if(collectionView === selectedBccUsersCollectionView)
        {
           return (dataCtrl?.bccUserList!.count)!
        }
        else if(collectionView === selectedForApprovalUsersCollectionView)
        {
             return (dataCtrl?.forApprovalUserList!.count)!
        }
        else if(collectionView === selectedForVerificationUsersCollectionView)
        {
             return (dataCtrl?.forVerificationUserList!.count)!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SelectedUsersCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"SelectedUsersCollectionViewCell", for: indexPath) as! SelectedUsersCollectionViewCell
        
        if(collectionView === selectedToUsersCollectionView)
        {
            let user:People = (dataCtrl?.toUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
            
        }
        else if(collectionView === selectedBccUsersCollectionView)
        {
            let user:People = (dataCtrl?.bccUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
        }
        else if(collectionView === selectedForApprovalUsersCollectionView)
        {
            let user:People = (dataCtrl?.forApprovalUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
        }
        else if(collectionView === selectedForVerificationUsersCollectionView)
        {
            let user:People = (dataCtrl?.forVerificationUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:false)
        }
        
        return cell
        
    }

    

    //MARK: Button Actions
    
    @IBAction func toButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.to
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func bccButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.bcc
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func approvalButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.forApproval
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func verificationButtonAction(_ sender: UIButton) {
        
        let selectUserVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "SelectUserViewController") as! SelectUserViewController
        selectUserVC.dataCtrl = dataCtrl
        selectUserVC.userType = NewConversationUserType.forVerification
        self.navigationController?.pushViewController(selectUserVC, animated: true)
    }
    
    @IBAction func attachmentButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func closeButtonAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func startConversationButtonAction(_ sender: UIButton) {
        
        //check for validation and do post call
    }
}
