//
//  ConversationsListViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationsListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,KRPullLoadViewDelegate,UISearchBarDelegate {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var conversationListTableView: UITableView!
    @IBOutlet weak var unreadConversationsLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var newConversationButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    let dataCtrl:ConversationsDataController = ConversationsDataController()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineLabel.layer.shadowColor = UIColor.lightGray.cgColor
        lineLabel.layer.shadowOffset = CGSize(width: 0, height: 0.6)
        lineLabel.layer.shadowOpacity = 1
        lineLabel.layer.shadowRadius = 1.0
        
        // add pull down and up refresh control
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self as KRPullLoadViewDelegate
        conversationListTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        conversationListTableView.addPullLoadableView(refreshView, type: .refresh)
        
        conversationListTableView.tableFooterView = UIView()
        searchBar.text = ""
        
        getConversations(isReload: true, searchText: searchBar.text!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
        
        conversationListTableView.reloadData()
        
        self.unreadConversationsLabel.text = String(dataCtrl.getUnreadConversationCount()) + " unread conversations"
        
        if(dataCtrl.isNewConversationAdded == true)
        {
            dataCtrl.isNewConversationAdded = false
            getConversations(isReload: false, searchText: searchBar.text!)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.endEditing(true)
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataCtrl.conversations.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ConversationListTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.conversationListTableView) as! ConversationListTableViewCell
        
        let conversation:Conversation = dataCtrl.conversations[indexPath.row]
        
        cell.loadCellWithConversation(conversation: conversation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let conversation:Conversation = dataCtrl.conversations[indexPath.row]
        dataCtrl.selectedCoversation = conversation
        
        dataCtrl.markCOnversationAsRead()
        
        let conversationDetailVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ConversationDetailViewController") as! ConversationDetailViewController
        conversationDetailVC.dataCtrl = self.dataCtrl
        self.navigationController?.pushViewController(conversationDetailVC, animated: true)
    }
    
    
    //MARK: Get Conversations
    
    func getConversations(isReload:Bool,searchText:String)
    {
        if Reachability.isConnectedToNetwork(){
            
            if(isReload){
                
                self.showLoadingOnViewController()
            }
            
            dataCtrl.getConversations(searchText:searchText , onSuccess: { [unowned self] (unreadConversationCount) in
                
                DispatchQueue.main.async {
                    
                    if(isReload){
                        
                        self.removeLoadingFromViewController()
                    }
                    
                    self.unreadConversationsLabel.text = String(unreadConversationCount) + " unread conversations"
                    
                    self.conversationListTableView.reloadData()
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
    
    //MARK: search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText == ""){
            
            getConversations(isReload: false, searchText: searchText)
        }
        else if (searchText.count > 2)
        {
            getConversations(isReload: false, searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        view.endEditing(true)
    }
    
    //MARK: Button Actions
    
    @IBAction func conversationsBarButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        
        let filterVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "FilterViewController")
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    
    @IBAction func newConversationButtonAction(_ sender: UIButton) {
        
        let newConversationVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "NewConversationViewController") as! NewConversationViewController
        newConversationVC.dataCtrl = dataCtrl
        self.navigationController?.pushViewController(newConversationVC, animated: true)
    }
    
    //MARK: Pull Up refresh control delegate
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                completionHandler()
                self.getConversations(isReload: false, searchText: searchBar.text!)
                
            default: break
            }
            return
        }
        
    switch state {
    
      case let .pulling(offset, threshould):
        if offset.y < threshould {
            
            self.getConversations(isReload: false, searchText: searchBar.text!)
        }
        
     case .none:
        break
        
     case .loading(let completionHandler):
        completionHandler()
        break
        }
    }
    
    //MARK: retry view delegate
    
    override func retryButtonClicked() {
        
        getConversations(isReload: true, searchText: searchBar.text!)
    }
}
