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
    
    let dataCtrl:NotificationDataController = NotificationDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.setUpNavigationController()
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
        
        let cell:NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        
        let notification:NotificationObject = dataCtrl.notifications[indexPath.row]
        
        cell.loadCellWith(notification)
        
        return cell
    }
    
    //MARK: Get Notifications
    
    func getNotifications(isReload:Bool,isRefresh:Bool)
    {
        if Reachability.isConnectedToNetwork() {
            
            if(isRefresh == false){
                
                self.showLoadingOnViewController()
            }
            
            dataCtrl.getNotifcations(isReload:isReload , onSuccess: { [unowned self] (unreadNotificationCount) in
                
                DispatchQueue.main.async {
                    
                    if(isRefresh == false){
                        
                        self.removeLoadingFromViewController()
                    }
                    
                   self.unreadNotificationLabel.text = String(unreadNotificationCount) + " unread notifications"

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
    
    //MARK: Pull Up refresh control delegate
    
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
               completionHandler()
                self.getNotifications(isReload: false,isRefresh: true)
                
            default: break
            }
            return
        }
        
        switch state {
            
        case let .pulling(offset, threshould):
            if offset.y < threshould {
                
                self.getNotifications(isReload: true,isRefresh: true)
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
