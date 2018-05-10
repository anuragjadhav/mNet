//
//  NotificationsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/19/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,KRPullLoadViewDelegate {

    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var unreadNotificationLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    @IBOutlet weak var noNotificationsLabel: CustomBrownTextColorLabel!
    
    let dataCtrl:NotificationDataController = NotificationDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterForeground), name:.UIApplicationWillEnterForeground, object: nil)

        lineLabel.layer.shadowColor = UIColor.lightGray.cgColor
        lineLabel.layer.shadowOffset = CGSize(width: 0, height: 0.6)
        lineLabel.layer.shadowOpacity = 1
        lineLabel.layer.shadowRadius = 1.0
        
        // add pull down and up refresh control
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self as KRPullLoadViewDelegate
        notificationsTableView.addPullLoadableView(loadMoreView, type: .loadMore)
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        notificationsTableView.addPullLoadableView(refreshView, type: .refresh)
        
        notificationsTableView.tableFooterView = UIView()
        
        getNotifications(isReload: true,isRefresh: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        self.setUpNavigationController()
        
        let currentTabbarItem = self.tabBarController?.tabBar.items![2]
        currentTabbarItem?.badgeValue = nil
        
        notificationsTableView.reloadData()
        
        checkIfNotificationDataPresentAndDeepLinkToVC()
    }
    
    func checkIfNotificationDataPresentAndDeepLinkToVC(){
        
        if let notifucationData = UserDefaults.standard.value(forKey: UserDefaultsKeys.notificationData)   as? [String:Any]
        {
            let notificationObject = NotificationObject(JSON: [String:String]())
            notificationObject?.postId = notifucationData["post_id"] as? String
            notificationObject?.approvalType = notifucationData["approval_type"] as? String
            notificationObject?.notificationType = notifucationData["notification_type"] as? String

            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.notificationData)
            UserDefaults.standard.synchronize()
            
            if(notificationObject != nil)
            {
                navigateToCorrespondingVC(notification: notificationObject!)

            }
        }
        
    }
    
    @objc func didEnterForeground()
    {
        getNotifications(isReload: true, isRefresh: false)
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataCtrl.notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.notificationTableViewCell) as! NotificationTableViewCell
        
        let notification:NotificationObject = dataCtrl.notifications[indexPath.row]
        
        cell.loadCellWith(notification)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let notificationObj:NotificationObject = dataCtrl.notifications[indexPath.row]
        dataCtrl.selectedNotification = notificationObj
        
        navigateToCorrespondingVC(notification: notificationObj)
      
    }
    
    
    func navigateToCorrespondingVC(notification:NotificationObject) {
    
        if(notification.status == "0")
        {
            dataCtrl.markNotificationAsRead()
            
            //reduce read count
            var count:Int = Int(dataCtrl.unreadNotificationCount!)!
            count -= 1
            count = count < 0 ? 0 : count
            dataCtrl.unreadNotificationCount = String(count)
            self.unreadNotificationLabel.text = self.dataCtrl.unreadNotificationCount! + " unread notifications"
        }
        
        if(notification.notificationType == "reply" || notification.notificationType == "post")
        {
            let conversationDetailVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationDetailViewController) as! ConversationDetailViewController
            conversationDetailVC.dataCtrl = ConversationsDataController()
            conversationDetailVC.didComeFromNotification = true
            conversationDetailVC.dataCtrl?.selectedNotification = notification
            self.navigationController?.pushViewController(conversationDetailVC, animated: true)
        }
        else {
            goToApprovalDetailsScreen(notification:notification)
        }
    }
    
    
    func goToApprovalDetailsScreen(notification:NotificationObject) {
        
        let approvalDataController:ApprovalsDataController = ApprovalsDataController()
        approvalDataController.selectedNotification = notification
        approvalDataController.isFromDeepLinking = true
        let approvalDetailsViewController:DocumentViewController = UIStoryboard.approvals.instantiateViewController(withIdentifier: StoryboardIDs.approvalDetailsViewController) as! DocumentViewController
        approvalDetailsViewController.dataController = approvalDataController
        self.navigationController?.pushViewController(approvalDetailsViewController, animated: true)
    }
    
    //MARK: Get Notifications
    
    func getNotifications(isReload:Bool,isRefresh:Bool)
    {
        if Reachability.isConnectedToNetwork() {
            
            if(isRefresh == false){
                
                self.showLoadingOnViewController()
            }
            
            dataCtrl.getNotifcations(isReload:isReload , onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    if(isRefresh == false){
                        
                        self.removeLoadingFromViewController()
                    }
                    
                    self.unreadNotificationLabel.text = self.dataCtrl.unreadNotificationCount! + " unread notifications"
                    self.checkNoData()
                    self.notificationsTableView.reloadData()
                 }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        if(isRefresh == false){
                            
                            self.removeLoadingFromViewController()
                            self.showRetryView(message:errorMessage)
                        }
                    }
            })
            
        }else{
            
            self.showRetryView(message: AlertMessages.networkUnavailable)
        }
    }
    
    func checkNoData() {
        
        noNotificationsLabel.isHidden = dataCtrl.notifications.count > 0
    }
    
    //MARK: Pull Up refresh control delegate
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
               completionHandler()
               
               if(dataCtrl.previousCallSuccessOrFailed){
                
                    self.getNotifications(isReload: false,isRefresh: true)
               }
                
            default: break
            }
            return
        }
        
        switch state {
            
        case let .pulling(offset, threshould):
            if offset.y < threshould {
                
                if(dataCtrl.previousCallSuccessOrFailed){
                    
                    self.getNotifications(isReload: true,isRefresh: true)

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
        
        getNotifications(isReload: true , isRefresh: false)
    }

}
