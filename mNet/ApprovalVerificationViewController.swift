//
//  ApprovalVerificationViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/30/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ApprovalVerificationViewController: BaseViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,RadioButtonGroupDelegate {
    
    @IBOutlet weak var approvalRadioButton: PVRadioButton!
    @IBOutlet weak var verificationRadioButton: PVRadioButton!
    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sendPeopleListTableView: UITableView!
    
    var radioButtonGroup:PVRadioButtonGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        radioButtonGroup = PVRadioButtonGroup()
        radioButtonGroup!.appendToRadioGroup(radioButtons: [approvalRadioButton,verificationRadioButton])
        radioButtonGroup!.delegate = self as RadioButtonGroupDelegate
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

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func checkBoxButtonAction(_ sender: UIButton) {
        
        let buttonPoint:CGPoint = sender.convert(CGPoint.zero, to: self.sendPeopleListTableView)
        let indexPath:IndexPath = self.sendPeopleListTableView.indexPathForRow(at: buttonPoint)!
        
        let cell:SendPeopleListTableViewCell =  self.sendPeopleListTableView.cellForRow(at: indexPath) as! SendPeopleListTableViewCell
        
         if(cell.isSelected == true)
         {
               cell.isSelected = false
               cell.checkBoxButton.setImage(UIImage.init(named: "uncheckedBox"), for: UIControlState.normal)
         }
        else
         {
            cell.checkBoxButton.setImage(UIImage.init(named: "checkedBox"), for: UIControlState.normal)
            cell.isSelected = true

         }
    }
    
    //Mark: search bar delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }

    
    // MARK: - Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func sendButtonAction(_ sender: Any) {
    }

    // MARK: - Radio Button Delegate
    
    func radioButtonClicked(button: PVRadioButton) {
        

    }


}
