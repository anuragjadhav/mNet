//
//  SelectUserViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit



class SelectUserViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,KRPullLoadViewDelegate {
    
    @IBOutlet weak var headerLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var selectUserTableView: UITableView!
    @IBOutlet weak var selectUserCollectionView: UICollectionView!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var selectUsersButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataCtrl:ConversationsDataController?
    var userType:String?
    
    //MARK: View Controller Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        selectUserTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        
        selectUserTableView.tableFooterView = UIView()
        searchBar.text = ""

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
        
        dataCtrl?.selectedUserType = userType
        
        if(dataCtrl?.selectUserList?.count == 0)
        {
            getSelectUserList(isReload: true,isLoadMore: false, searchText: searchBar.text!)
        }
        else
        {
            dataCtrl?.filterSelectUsersListBasedOnSelectedUserType()
            selectUserTableView.reloadData()
            selectUserCollectionView.reloadData()
        }
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: TableView Delegates And Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dataCtrl?.selectUserList!.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SelectUserTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SelectUserTableViewCell") as! SelectUserTableViewCell
        
        let user:People = (dataCtrl?.selectUserList![indexPath.row])!
        
        if(userType == NewConversationUserType.bcc)
        {
            cell.loadCellWith(user: user, isSelected: user.isSelectedForBcc)
        }
        else if(userType == NewConversationUserType.to)
        {
            cell.loadCellWith(user: user, isSelected: user.isSelectedForTo)
        }
        else if(userType == NewConversationUserType.forVerification)
        {
            cell.loadCellWith(user: user, isSelected: user.isSelectedForVerification)
        }
        else if(userType == NewConversationUserType.forApproval)
        {
            cell.loadCellWith(user: user, isSelected: user.isSelectedForApproval)
        }
        
        return cell
    }
    
    //MARK: CollectionView Delegates And Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(userType == NewConversationUserType.bcc)
        {
            return (dataCtrl?.getBccSelectedUsersCount())!
        }
        else if(userType == NewConversationUserType.to)
        {
            return (dataCtrl?.getToSelectedUsersCount())!
        }
        else if(userType == NewConversationUserType.forVerification)
        {
            return (dataCtrl?.getVerificationSelectedUsersCount())!
        }
        else if(userType == NewConversationUserType.forApproval)
        {
            return  (dataCtrl?.getApprovalSelectedUsersCount())!
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SelectedUsersCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"SelectedUsersCollectionViewCell", for: indexPath) as! SelectedUsersCollectionViewCell
        
        if(userType == NewConversationUserType.bcc)
        {
            let user:People = (dataCtrl?.bccUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:true)
        }
        else if(userType == NewConversationUserType.to)
        {
            let user:People = (dataCtrl?.toUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:true)
        }
        else if(userType == NewConversationUserType.forVerification)
        {
            let user:People = (dataCtrl?.forVerificationUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:true)
        }
        else if(userType == NewConversationUserType.forApproval)
        {
            let user:People = (dataCtrl?.forApprovalUserList![indexPath.row])!
            cell.loadCellWithUser(user: user, showDeleteButton:true)
        }
        
        return cell
    }
    

    //MARK: Search Bar Delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText == ""){
            
            getSelectUserList(isReload: false,isLoadMore: false, searchText: searchText)
        }
        else if (searchText.count > 2)
        {
            getSelectUserList(isReload: false,isLoadMore: false, searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    
    //MARK: Get User List
    
    func getSelectUserList(isReload:Bool,isLoadMore:Bool,searchText:String)
    {
        if Reachability.isConnectedToNetwork(){
            
            if(isReload){
                
                self.showLoadingOnViewController()
            }
            
            dataCtrl?.getSelectUserList(searchText:searchText,isLoadMore:isLoadMore, onSuccess: { [unowned self]  in
                
                DispatchQueue.main.async {
                    
                    if(isReload){
                        
                        self.removeLoadingFromViewController()
                    }

                    self.selectUserTableView.reloadData()
                    self.selectUserCollectionView.reloadData()
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        if(isReload){
                            
                            self.removeLoadingFromViewController()
                            self.showRetryView(message:errorMessage)
                        }
                    }
            })
            
        }else{
            
            self.showRetryView(message: AlertMessages.networkUnavailable)
        }
    }
    
    //MARK: Pull Up refresh control delegate
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                completionHandler()
                self.getSelectUserList(isReload: false,isLoadMore:true,  searchText: searchBar.text!)
                
            default: break
            }
            return
        }
    }
    
    //MARK: retry view delegate
    
    override func retryButtonClicked() {
        
        getSelectUserList(isReload: true,isLoadMore: false, searchText: searchBar.text!)
    }

    //MARK: Button Actions
    
    @IBAction func tickButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.selectUserTableView)
        let indexPath:IndexPath = self.selectUserTableView.indexPathForRow(at: buttonPoint)!
        
        let user:People = (dataCtrl?.selectUserList![indexPath.row])!
        let cell:SelectUserTableViewCell = selectUserTableView.cellForRow(at: indexPath) as! SelectUserTableViewCell
        
        if(userType == NewConversationUserType.bcc)
        {
            user.isSelectedForBcc =  user.isSelectedForBcc ? false : true
            cell.loadCellWith(user: user, isSelected: user.isSelectedForBcc)
        }
        else if(userType == NewConversationUserType.to)
        {
            user.isSelectedForTo =  user.isSelectedForTo ? false : true
            cell.loadCellWith(user: user, isSelected: user.isSelectedForTo)
        }
        else if(userType == NewConversationUserType.forVerification)
        {
            user.isSelectedForVerification =  user.isSelectedForVerification ? false : true
            cell.loadCellWith(user: user, isSelected: user.isSelectedForVerification)
        }
        else if(userType == NewConversationUserType.forApproval)
        {
            user.isSelectedForApproval =  user.isSelectedForApproval ? false : true
            cell.loadCellWith(user: user, isSelected: user.isSelectedForApproval)
        }
        
        // reload collection view to show selected user selection
        selectUserCollectionView.reloadData()
    }
    
    @IBAction func deleteSelectedUserButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.selectUserCollectionView)
        let indexPath:IndexPath = self.selectUserCollectionView.indexPathForItem(at: buttonPoint)!
        
        if(userType == NewConversationUserType.bcc)
        {
            let user:People = (dataCtrl?.bccUserList![indexPath.row])!
            user.isSelectedForBcc = false
        }
        else if(userType == NewConversationUserType.to)
        {
            let user:People = (dataCtrl?.toUserList![indexPath.row])!
            user.isSelectedForTo =  false
        }
        else if(userType == NewConversationUserType.forVerification)
        {
            let user:People = (dataCtrl?.forVerificationUserList![indexPath.row])!
            user.isSelectedForVerification =  false
        }
        else if(userType == NewConversationUserType.forApproval)
        {
            let user:People = (dataCtrl?.forApprovalUserList![indexPath.row])!
            user.isSelectedForApproval =  false
        }
        
        selectUserCollectionView.reloadData()
        selectUserTableView.reloadData()
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectUsersButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

    }
}
