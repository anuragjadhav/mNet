//
//  ConversationsListViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationsListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var conversationListTableView: UITableView!
    @IBOutlet weak var unreadConversationsLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var newConversationButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: View Controller Delegates
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
        
        let cell:ConversationListTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.conversationListTableView) as! ConversationListTableViewCell
        cell.setUpCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let conversationDetailVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ConversationDetailViewController")
        self.navigationController?.pushViewController(conversationDetailVC, animated: true)
    }
    
    //MARK: Button Actions
    
    @IBAction func conversationsBarButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        
        let filterVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "FilterViewController")
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    
    @IBAction func newConversationButtonAction(_ sender: UIButton) {
        
        let newConversationVC = (UIStoryboard.init(name:"Conversation", bundle: Bundle.main)).instantiateViewController(withIdentifier: "NewConversationViewController")
        self.navigationController?.pushViewController(newConversationVC, animated: true)
    }
    
}
