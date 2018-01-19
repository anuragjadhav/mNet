//
//  NotificationsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/19/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notificationsTableView: UITableView!
    @IBOutlet weak var unreadNotificationLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var lineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineLabel.layer.shadowColor = UIColor.lightGray.cgColor
        lineLabel.layer.shadowOffset = CGSize(width: 0, height: 0.6)
        lineLabel.layer.shadowOpacity = 1
        lineLabel.layer.shadowRadius = 1.0
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
        
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NotificationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        return cell
    }
    

    // MARK: - Button Actions
    
    @IBAction func notificationButtonAction(_ sender: Any){
        
    }
    
}
