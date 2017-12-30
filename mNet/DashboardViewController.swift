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
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:Setup
    func setUpViewController()  {
        
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

    
    
    
}
