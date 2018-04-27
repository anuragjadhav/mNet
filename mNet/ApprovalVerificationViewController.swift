//
//  ApprovalVerificationViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/30/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit


class ApprovalVerificationViewController: BaseViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,RadioButtonGroupDelegate,UITextViewDelegate {
    
    //MARK: Outlets and Properties
    
    //Outlets
    @IBOutlet weak var approvalRadioButton: PVRadioButton!
    @IBOutlet weak var verificationRadioButton: PVRadioButton!
    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sendPeopleListTableView: UITableView!
    @IBOutlet weak var approveRadioButtonTop: NSLayoutConstraint!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sendButton: CustomBlueBackgroundButton!
    
    //Properties
    var radioButtonGroup:PVRadioButtonGroup?
    var dataController:ApprovalsDataController = ApprovalsDataController()
    var searchTextEntered:String? = nil
    var userList:[ApprovalUser] = [ApprovalUser]()
    
    var approvalsVC:ApprovalsViewController?
    
    //MARK: View Controller Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }
    
    //MARK: Setup
    
    func setUpViewController() {
                
        switch dataController.selectedSection!.approvalStatus {
        
        case .approve: hideRadioButtons()
        
        case .verify: showRadioButtons()
        
        default: hideRadioButtons()
        
        }
        
        self.view.layoutIfNeeded()
    }
    
    func showRadioButtons() {
        
        radioButtonGroup = PVRadioButtonGroup()
        approvalRadioButton.tag = 1
        verificationRadioButton.tag = 2
        radioButtonGroup!.appendToRadioGroup(radioButtons: [approvalRadioButton,verificationRadioButton])
        radioButtonGroup!.delegate = self as RadioButtonGroupDelegate
        approveRadioButtonTop.constant = 28
        textViewHeight.constant = 64
        sendButton.setTitle(ConstantStrings.verify, for: .normal)
        sendPeopleListTableView.isHidden = false
        searchBar.isHidden = false
        approvalRadioButton.isHidden = false
        verificationRadioButton.isHidden = false
        approvalRadioButton.isRadioSelected = true
        reloadData()
    }
    
    func hideRadioButtons() {
        
        radioButtonGroup = PVRadioButtonGroup()
        approveRadioButtonTop.constant = -20
        textViewHeight.constant = 128
        sendButton.setTitle(ConstantStrings.approve, for: .normal)
        sendPeopleListTableView.isHidden = true
        searchBar.isHidden = true
        approvalRadioButton.isHidden = true
        verificationRadioButton.isHidden = true
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: tableview delegates and data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SendPeopleListTableViewCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifiers.sendPeopleListTableViewCell) as! SendPeopleListTableViewCell
        
        guard let user:ApprovalUser = userList[safe:indexPath.row] else {
            return cell
        }
        cell.setUpCell(user: user, isUserSelected: dataController.selectedApproval!.selectedUsers.contains(user))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedUser:ApprovalUser = userList[indexPath.row]
        dataController.selectedApproval!.selectedUsers.removeAll()
        dataController.selectedApproval!.selectedUsers.append(selectedUser)
        sendPeopleListTableView.reloadData()
    }
    
    //MARK: Text View Delegates
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            self.view.endEditing(true)
        }
        return true
    }
    
    
    //MARK: search bar delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchTextEntered = nil
        }
        else {
            searchTextEntered = searchText
        }
        reloadData()
    }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTextEntered = searchBar.text
        self.view.endEditing(true)
        reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchTextEntered = nil
        searchBar.text = ""
        self.view.endEditing(true)
        reloadData()
    }

    
    // MARK: - Button Actions
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func sendButtonAction(_ sender: Any) {
        
        if dataController.selectedApproval!.selectedUsers.count <= 0 && dataController.selectedSection!.approvalStatus == .verify {
            self.showQuickErrorAlert(message: AlertMessages.selectAtleastOneUSer)
            return
        }
        
        self.showTransperantLoadingOnViewController()
        
        var messageText:String? =  messageTextView.text
        if messageText == nil || messageText!.isEmpty || messageText! == "" {
            if verificationRadioButton.isRadioSelected {
                messageText = ConstantStrings.verifiedMessge
            }
            else {
                messageText = ConstantStrings.approvedMessage
            }
        }
        
        var approveType:String = "A"
        if verificationRadioButton.isRadioSelected {
            approveType = "I"
        }
        
        dataController.approvePostBasedOnType(replyMessage: messageText!, approveType: approveType, onSuccess: { (message) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                var successMessage:String = AlertMessages.approvalSuccess
                if self.verificationRadioButton.isRadioSelected {
                    successMessage = AlertMessages.verificationSuccess
                }
                self.showQuickSuccessAlert(message: successMessage, completion: { (_) in
                    self.approvalsVC?.resetData()
                    self.approvalsVC?.getData()
                    self.navigationController?.popToViewController(self.approvalsVC!, animated: true)
                })
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickErrorAlert(message: errorMessage)
            }
        }
    }

    // MARK: - Radio Button Delegate
    
    func radioButtonClicked(button: PVRadioButton) {
        
        sendPeopleListTableView.reloadData()
        dataController.selectedApproval!.selectedUsers.removeAll()
        reloadData()
    }

    func reloadData() {
        
        if approvalRadioButton.isRadioSelected {
            userList =  dataController.selectedApproval!.approvalUserList
        }
        else {
            userList = dataController.selectedApproval!.verificationUserList
        }
        
        if searchTextEntered != nil {
            userList = userList.filter({ (user) -> Bool in
                return user.name.contains(searchTextEntered!)
            })
        }
        
        sendPeopleListTableView.reloadData()
    }

}
