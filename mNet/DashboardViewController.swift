//
//  DashboardViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 29/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Outlets and Properties
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var dashboardTitleLabel: UILabel!
    
    @IBOutlet weak var pendingApprovalsLabel: UILabel!
    @IBOutlet weak var pendingApprovalsCountLabel: UILabel!
    
    @IBOutlet weak var pendingVerificationsLabel: UILabel!
    @IBOutlet weak var pendingVerificationsCountLabel: UILabel!
    
    @IBOutlet weak var unreadMessagesLabel: UILabel!
    @IBOutlet weak var unreadMessagesCountLabel: UILabel!
    
    @IBOutlet weak var myAppsLabel: UILabel!
    @IBOutlet weak var myAppsTableView: UITableView!
        
    @IBOutlet weak var noAppsLabel: CustomBrownTextColorLabel!
    
    
    var dataController:DashboardDataController = DashboardDataController()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAnyPushNotification), name:.UIApplicationDidBecomeActive, object: nil)

        // Do any additional setup after loading the view.
        setUpViewController()
        
        getData()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false

        self.setUpNavigationController()
        
    }

    //MARK:Setup
    func setUpViewController() {
        
        myAppsTableView.tableFooterView = UIView()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(refreshTableViewData),
                                 for: .valueChanged)
        myAppsTableView.refreshControl = refreshControl
    }
    
    func setUpNavigationController()  {
        
        guard let baseNavigationController:BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        baseNavigationController.showLargeTitles()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getData(showStransperantLoading:Bool = false) {
        
        if showStransperantLoading
        {
            self.showTransperantLoadingOnViewController()
        }
        else
        {
            self.showLoadingOnViewController()
        }
        
        dataController.getDashboardData(onSuccess: { [unowned self] in
            
            DispatchQueue.main.async {
                
                if showStransperantLoading
                {
                    self.removeTransperantLoadingFromViewController()
                }
                else
                {
                    self.removeLoadingFromViewController()
                }
                
                self.setData()
            }
            
        }) { [unowned self] (errorMessage) in
            
            DispatchQueue.main.async {
                
                if showStransperantLoading
                {
                    self.removeTransperantLoadingFromViewController()
                }
                else
                {
                    self.removeLoadingFromViewController()
                }
                
                self.showRetryView(message: errorMessage)
            }
        }
    }
    
    func getDashboardStats() {
        
        self.showTransperantLoadingOnViewController()
        
        dataController.getDashboardStats( onSuccess: { [unowned self] in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.setData()
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showRetryView(message: errorMessage)
                self.checkNoApps()
            }
        }
        
    }
    
    func setData() {
        
        checkNoApps()
        pendingApprovalsCountLabel.text = String(describing: dataController.stats?.pendingApprovalRequests ?? 0)
        pendingVerificationsCountLabel.text = String(describing: dataController.stats?.pendingAgreeRequests ?? 0)
        unreadMessagesCountLabel.text = dataController.stats?.unreadPosts ?? "-"
        self.myAppsTableView.reloadData()
        
        //set unread notification count and conversation count
        
        let conversationTabBar:UITabBarItem = (self.tabBarController?.tabBar.items![1])!
        let notificationTabBar:UITabBarItem = (self.tabBarController?.tabBar.items![2])!
        
        if(dataController.stats?.unreadPosts != "0"){
            
            conversationTabBar.badgeValue = dataController.stats?.unreadPosts
            if #available(iOS 10.0, *) {
                conversationTabBar.badgeColor = ColorConstants.kBrownColor
            }
        }

        if(dataController.stats?.notificationCount != "0"){
            notificationTabBar.badgeValue = dataController.stats?.notificationCount
            if #available(iOS 10.0, *) {
                notificationTabBar.badgeColor = ColorConstants.kBrownColor
            }
        }
    }
    
    func checkNoApps() {
        
        noAppsLabel.isHidden = dataController.appsList.count > 0
    }
    
    @objc func didReceiveAnyPushNotification()
    {
        
        if (UserDefaults.standard.value(forKey: UserDefaultsKeys.notificationData)   as? [String:Any]) != nil {
            
            self.tabBarController?.selectedIndex = 2
        }

    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.appsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DashboardMyAppsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.dashboardMyAppsTableView) as! DashboardMyAppsTableViewCell
        cell.setUpCell(app: dataController.appsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let app:UserApp = dataController.appsList[indexPath.row]
        
        if(app.allowInMobile == "0")
        {
            DispatchQueue.main.async {
                
                let alertController:UIAlertController = UIAlertController(title: "Coming Soon", message: "This app is coming soon for mobile.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: AlertMessages.ok, style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else
        {
            if app.appId == "3" || app.appName == "Approvals" {
                goToApprovalsScreen(preSelectedIndex:0)
            }
                
            else {
                
                self.tabBarController?.tabBar.isHidden = true
                
                let webViewController:WebViewController = UIStoryboard.webView.instantiateViewController(withIdentifier: StoryboardIDs.webViewController) as! WebViewController
                webViewController.setData(url: app.appURL, header: app.appName)
                navigationController?.pushViewController(webViewController, animated: true)
            }
        }
    }
    
    func goToApprovalsScreen(preSelectedIndex:Int) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let approvalsVC:ApprovalsViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ApprovalsViewController") as! ApprovalsViewController
        let dataController:ApprovalsDataController = ApprovalsDataController()
        dataController.selectedSectionIndex = preSelectedIndex
        approvalsVC.dataController = dataController
        approvalsVC.dashBoardVC = self
        self.navigationController?.pushViewController(approvalsVC, animated: true)
    }
    
    //MARK: Button Actions
    @IBAction func starButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.myAppsTableView)
        let indexPath:IndexPath = self.myAppsTableView.indexPathForRow(at: buttonPoint)!
        let selectedApp:UserApp = dataController.appsList[indexPath.row]
        self.showTransperantLoadingOnViewController()
        dataController.setAppPriority(app: selectedApp, onSuccess: {
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.myAppsTableView.reloadData()
            }
        }) { (errorMessage) in
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                self.showQuickErrorAlert(message: errorMessage)
            }
        }
        
    }
    
    override func retryButtonClicked() {
        
        getData()
    }
    
    
    @IBAction func pendingApprovalsButtonAction(_ sender: UIButton) {
        
        goToApprovalsScreen(preSelectedIndex:0)
//        if dataController.appsList.contains(where: { (app) -> Bool in
//            return app.appId == "3"
//        }) {
//
//
//        }
    }
    
    
    
    @IBAction func pendingVerificationsButtonAction(_ sender: UIButton) {
        
        goToApprovalsScreen(preSelectedIndex:1)
        
//        if dataController.appsList.contains(where: { (app) -> Bool in
//            return app.appId == "3"
//        }) {
//
//            goToApprovalsScreen(preSelectedIndex:1)
//        }
    }
    
    
    @IBAction func unreadMessagesButtonAction(_ sender: UIButton) {
        
        self.tabBarController?.selectedIndex = 1
    }
    
    
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        
        getData(showStransperantLoading: true)
    }
    
    @objc func refreshTableViewData()
    {
        dataController.getDashboardApps(onSuccess: { [unowned self] in
            
            DispatchQueue.main.async {
                self.myAppsTableView.refreshControl?.endRefreshing()
                self.myAppsTableView.reloadData()
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                self.myAppsTableView.refreshControl?.endRefreshing()
            }
            
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
                
        if(gestureRecognizer is UIScreenEdgePanGestureRecognizer)
        {
            return false
        }
        
        return true
    }
    
}
