//
//  ApprovalVerificationViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/30/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ApprovalVerificationViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var approvalRadioButton: ISRadioButton!
    @IBOutlet weak var verificationRadioButton: ISRadioButton!
    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sendPeopleListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SendPeopleListTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SendPeopleListTableViewCell") as! SendPeopleListTableViewCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let cell:SendPeopleListTableViewCell =  tableView.cellForRow(at: indexPath) as! SendPeopleListTableViewCell
        
       cell.checkBoxButton.setImage(UIImage.init(named: "checkedBox"), for: UIControlState.normal)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell:SendPeopleListTableViewCell =  tableView.cellForRow(at: indexPath) as! SendPeopleListTableViewCell
        
        cell.checkBoxButton.setImage(UIImage.init(named: "uncheckedBox"), for: UIControlState.normal)
    }
    
    //Mark: search bar delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }

    
    // MARK: - Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func sendButtonAction(_ sender: Any) {
    }

    @IBAction func radioButtonAction(_ sender: Any) {
    }
 

}
