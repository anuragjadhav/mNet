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
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myAppsTableView.tableFooterView = UIView()
        logoutButton.imageView?.image = logoutButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        logoutButton.imageView?.tintColor = ColorConstants.kWhiteColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
    }

    //MARK:Setup
    func setUpNavigationController()  {
        
        guard let baseNavigationController:BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        baseNavigationController.showLargeTitles()
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DashboardMyAppsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.dashboardMyAppsTableView) as! DashboardMyAppsTableViewCell
        cell.setUpCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let approvalsVC = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ApprovalsViewController")
        self.navigationController?.pushViewController(approvalsVC, animated: true)
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
    
    @IBAction func logOutAction(_ sender: UIButton) {
        
        AppDelegate.sharedInstance.logout()
    }
    
}
