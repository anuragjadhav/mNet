//
//  ConversationInfoViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 31/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationInfoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: Outlets and Properties
    @IBOutlet weak var user1Label: CustomBrownTextColorLabel!
    
    @IBOutlet weak var user2Label: CustomBrownTextColorLabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    @IBOutlet weak var membersLabel: CustomBlueTextColorLabel!
    
    @IBOutlet weak var membersTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MembersTableViewCell = tableView.dequeueReusableCell(withIdentifier:"MembersTableViewCell") as! MembersTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: Button Actions
 
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
