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
    
    var didComeFromNotification:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name:.UIApplicationDidBecomeActive, object: nil)

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
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        checkIfNotificationDataPresentAndDeepLinkToVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        
        self.notificationsTableView.reloadData()
        
        if(didComeFromNotification)
        {
            didComeFromNotification = false
            getNotifications(isReload: true, isRefresh: false)
        }
    }
    
    func checkIfNotificationDataPresentAndDeepLinkToVC(){
        
        if let notifucationData = UserDefaults.standard.value(forKey: UserDefaultsKeys.notificationData)   as? [String:Any]
        {
            let notificationObject = NotificationObject(JSON: [String:String]())
            
            notificationObject?.postId = notifucationData["post_id"] as? String
            
            if(notificationObject?.postId == nil)
            {
                notificationObject?.postId = String(notifucationData["post_id"] as! Int)
            }
            
            notificationObject?.approvalType = notifucationData["approval_type"] as? String
            notificationObject?.notificationType = notifucationData["notification_type"] as? String

            UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.notificationData)
            UserDefaults.standard.synchronize()
            
            if(notificationObject != nil)
            {
                dataCtrl.selectedNotification = notificationObject
                didComeFromNotification = true
                navigateToCorrespondingVC(notification: notificationObject!,didComeFromNotif:true)

            }
        }
    }
    
    @objc func didBecomeActive()
    {
        checkIfNotificationDataPresentAndDeepLinkToVC()
        
        if(didComeFromNotification == false && dataCtrl.previousCallSuccessOrFailed == true)
        {
            getNotifications(isReload: true,isRefresh: false)
        }
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
        
        
        let notificationObj:NotificationObject = dataCtrl.notifications[indexPath.row]
        dataCtrl.selectedNotification = notificationObj
        
        navigateToCorrespondingVC(notification: notificationObj)
      
    }
    
    
    func navigateToCorrespondingVC(notification:NotificationObject,didComeFromNotif:Bool = false) {
    
        if(notification.notificationId != nil && notification.status == "0")
        {
            dataCtrl.markNotificationAsRead()
            
            //reduce read count
            var count:Int = Int(dataCtrl.unreadNotificationCount!)!
            count -= 1
            count = count < 0 ? 0 : count
            dataCtrl.unreadNotificationCount = String(count)
            self.unreadNotificationLabel.text = self.dataCtrl.unreadNotificationCount! + " unread notifications"
        }
        
        if(didComeFromNotif)
        {
            if((notification.notificationType == "conversation"))
            {
                self.tabBarController?.tabBar.isHidden = true
                
                let conversationDetailVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationDetailViewController) as! ConversationDetailViewController
                conversationDetailVC.dataCtrl = ConversationsDataController()
                conversationDetailVC.didComeFromNotification = true
                conversationDetailVC.dataCtrl?.selectedNotification = notification
                self.navigationController?.pushViewController(conversationDetailVC, animated: true)
            }
            else {
                self.tabBarController?.tabBar.isHidden = true
                goToApprovalDetailsScreen(notification:notification)
            }
        }
        else
        {
            if((notification.notificationType == "reply" || notification.notificationType == "post")  && (notification.approvalType == nil || notification.approvalType == "" || notification.approvalType == "null"))
            {
                self.tabBarController?.tabBar.isHidden = true
                
                let conversationDetailVC = UIStoryboard.conversations.instantiateViewController(withIdentifier: StoryboardIDs.conversationDetailViewController) as! ConversationDetailViewController
                conversationDetailVC.dataCtrl = ConversationsDataController()
                conversationDetailVC.didComeFromNotification = true
                conversationDetailVC.dataCtrl?.selectedNotification = notification
                self.navigationController?.pushViewController(conversationDetailVC, animated: true)
            }
            else {
                self.tabBarController?.tabBar.isHidden = true
                goToApprovalDetailsScreen(notification:notification)
            }
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if(gestureRecognizer is UIScreenEdgePanGestureRecognizer)
        {
            return false
        }
        
        return true
    }

}
