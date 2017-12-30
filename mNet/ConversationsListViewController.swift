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
    
    @IBOutlet weak var conversationBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var filterBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var unreadConversationsLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var newConversationButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    //MARK: Setup
    func setUpViewController() {
        
        conversationListTableView.contentInset = UIEdgeInsets(top: -searchBar.frame.height, left: 0, bottom: 100, right: 0)
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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Button Actions
    
    @IBAction func conversationsBarButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func filterButtonAction(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func newConversationButtonAction(_ sender: UIButton) {
        
    }
    
}
