//
//  ConversationsListViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationsListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,KRPullLoadViewDelegate,UISearchBarDelegate,HideIgnorePostDelegate,DateSelectorDeleagte {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var conversationListTableView: UITableView!
    @IBOutlet weak var unreadConversationsLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var newConversationButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var noConversationsLabel: CustomBrownTextColorLabel!
    
    
    let dataCtrl:ConversationsDataController = ConversationsDataController()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAnyPushNotification), name:.UIApplicationWillEnterForeground, object: nil)
        
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
        
        getConversations(isReload: true,isLoadMore: false, searchText: searchBar.text!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
        
        conversationListTableView.reloadData()
        
        self.unreadConversationsLabel.text = dataCtrl.unreadConversationCount + " unread conversations"
        
        if(dataCtrl.isNewConversationAdded == true || dataCtrl.newUsersAddedToConversation == true)
        {
            dataCtrl.isNewConversationAdded = false
            dataCtrl.newUsersAddedToConversation = false
            getConversations(isReload: true,isLoadMore: false, searchText: searchBar.text!)
        }
        
        let currentTabbarItem = self.tabBarController?.tabBar.items![1]
        currentTabbarItem?.badgeValue = nil
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
        dataCtrl.selectedConversationIndex = indexPath.row
        
        if(conversation.readState == "0")
        {
            dataCtrl.markCOnversationAsRead()
            
            //reduce read count
            var count:Int = Int(dataCtrl.unreadConversationCount)!
            count -= 1
            dataCtrl.unreadConversationCount = String(count)
            self.unreadConversationsLabel.text = self.dataCtrl.unreadConversationCount + " unread conversations"
            
        }
        
        let conversationDetailVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationDetailViewController) as! ConversationDetailViewController
        conversationDetailVC.dataCtrl = self.dataCtrl
        conversationDetailVC.hideIgnorePostdelegate = self
        self.navigationController?.pushViewController(conversationDetailVC, animated: true)
    }
    
    //MARK: Push Notification
    
    @objc func didReceiveAnyPushNotification()
    {
        let didReceivePusnNotif:Bool = UserDefaults.standard.bool(forKey: UserDefaultsKeys.didReceiveNotification)
        
        if didReceivePusnNotif == true {
            
            self.tabBarController?.selectedIndex = 2
        }
        
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.didReceiveNotification)
        UserDefaults.standard.synchronize()
    }
    
    
    //MARK: Get Conversations
    
    func getConversations(isReload:Bool,isLoadMore:Bool,searchText:String)
    {
        if Reachability.isConnectedToNetwork(){
            
            if(isReload){
                
                self.showLoadingOnViewController()
            }
            
            dataCtrl.getConversations(searchText:searchText,isLoadMore:isLoadMore , onSuccess: { [unowned self]  in
                
                DispatchQueue.main.async {
                    
                    if(isReload){
                        
                        self.removeLoadingFromViewController()
                    }
                    
                    self.unreadConversationsLabel.text = self.dataCtrl.unreadConversationCount + " unread conversations"
                    self.checkNoData()
                    self.conversationListTableView.reloadData()
                    self.setFilterLabel()
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
    
    func setFilterLabel()
    {
        switch self.dataCtrl.filterString ?? "" {
            
        case "1":   self.filterLabel.isHidden = false
        self.filterLabel.text = " Today "
            
        case "2":   self.filterLabel.isHidden = false
        self.filterLabel.text = " Past Week "
            
        case "3":   self.filterLabel.isHidden = false
        self.filterLabel.text = " Past Fifteen Days "
            
        case "4":   self.filterLabel.isHidden = false
        self.filterLabel.text = " Past Month "
            
        case "5":   self.filterLabel.isHidden = false
        self.filterLabel.text = " \(self.dataCtrl.startDate.shortDateFromDDMMYY()) to \(self.dataCtrl.endDate.shortDateFromDDMMYY()) "
            
        default:    self.filterLabel.isHidden = true
        self.filterLabel.text = ""
            
        }
        
    }
    
    func checkNoData() {
        
        noConversationsLabel.isHidden = ((dataCtrl.conversations.count) > 0)
    }
    
    //MARK: search bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(searchText == "" || searchText.count > 2){
            
            getConversations(isReload: false,isLoadMore: false, searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        view.endEditing(true)
    }
    
    //MARK: Button Actions
    

    @IBAction func filterButtonAction(_ sender: UIButton) {
        
        let dateFilter:DateSelectorViewController = UIStoryboard.dateSelector.instantiateViewController(withIdentifier: StoryboardIDs.dateFilterViewController) as! DateSelectorViewController
        dateFilter.delegate = self
        self.present(dateFilter, animated: false, completion: nil)
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
                
                if(dataCtrl.previousConversationCallSuccessOrFailed){
                    self.getConversations(isReload: false,isLoadMore: true, searchText: searchBar.text!)
                }
                
            default: break
            }
            return
        }
        
    switch state {
    
      case let .pulling(offset, threshould):
        if offset.y < threshould {
            
           
            if(dataCtrl.previousConversationCallSuccessOrFailed){
                print("threshould: \(threshould)")
                print("offset: \(offset.y)")

                self.getConversations(isReload: false,isLoadMore: false, searchText: searchBar.text!)
            }
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
        
        getConversations(isReload: true,isLoadMore: false, searchText: searchBar.text!)
    }
    
    //MARK: Hide Ignore Post Success Delegate
    
    func hideIgnorePostSuccess() {
        
        self.conversationListTableView.reloadData()
    }
    
    //MARK: Date Selector Success Delegate
    
    func didSelectDate(filterString: String?, fromDate: String?, toDate: String?) {
        
        dataCtrl.filterString = filterString
        dataCtrl.startDate = fromDate ?? ""
        dataCtrl.endDate = toDate ?? ""
        getConversations(isReload: true,isLoadMore: false, searchText: searchBar.text!)
    }
}
