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
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var dataController:DashboardDataController = DashboardDataController()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
    }

    //MARK:Setup
    func setUpViewController() {
        
        getData()
        myAppsTableView.tableFooterView = UIView()
        logoutButton.imageView?.image = logoutButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        logoutButton.imageView?.tintColor = ColorConstants.kWhiteColor
    }
    
    func setUpNavigationController()  {
        
        guard let baseNavigationController:BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        baseNavigationController.showLargeTitles()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func getData() {
        
        self.showLoadingOnViewController()
        
        dataController.getDashboardData(onSuccess: { [unowned self] in
            
            self.removeLoadingFromViewController()
            self.setData()
            
        }) { [unowned self] (errorMessage) in
            
            self.removeLoadingFromViewController()
            self.showRetryView(message: errorMessage)
        }
    }
    
    func setData() {
        
        pendingApprovalsCountLabel.text = String(describing: dataController.stats?.pendingApprovalRequests ?? 0)
        pendingVerificationsCountLabel.text = String(describing: dataController.stats?.pendingAgreeRequests ?? 0)
        unreadMessagesCountLabel.text = dataController.stats?.unreadPosts ?? "-"
        self.myAppsTableView.reloadData()
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
        
        if app.appId == "3" {
            let approvalsVC = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ApprovalsViewController")
            self.navigationController?.pushViewController(approvalsVC, animated: true)
        }
        
        else {
            let webViewController:WebViewController = UIStoryboard.login.instantiateViewController(withIdentifier: StoryboardIDs.webViewController) as! WebViewController
            webViewController.setData(url: app.appURL, header: app.appName)
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
    
    //Mark: Button Actions
    @IBAction func starButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.myAppsTableView)
        let indexPath:IndexPath = self.myAppsTableView.indexPathForRow(at: buttonPoint)!
        
        let cell:DashboardMyAppsTableViewCell =  self.myAppsTableView.cellForRow(at: indexPath) as! DashboardMyAppsTableViewCell
        
        if(cell.isSelected == true)
        {
            cell.isSelected = false
            cell.starButton.setImage(UIImage.init(named: "star_empty"), for: UIControlState.normal)
        }
        else
        {
            cell.starButton.setImage(UIImage.init(named: "star_filled"), for: UIControlState.normal)
            cell.isSelected = true
            
        }
    }
    
    override func retryButtonClicked() {
        
        getData()
    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
        
        AppDelegate.sharedInstance.logout()
    }
    
}
