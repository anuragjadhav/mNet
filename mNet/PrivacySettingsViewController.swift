//
//  PrivacySettingsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PrivacySettingsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak private var optionsTableView: UITableView!
    
    var dataCtrl:SettingsProfileDataController?
    var selectedIndexPath:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionsTableView.estimatedRowHeight = 73
        optionsTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
        self.dataCtrl?.setupPrivacySettingOptionsArray()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataCtrl!.privacySettingOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PrivacySettingOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifiers.privacySettingsOptionTableViewCell) as! PrivacySettingOptionTableViewCell
        
        let option = self.dataCtrl?.privacySettingOptionsArray[indexPath.row]
        
        cell.loadCellWithOption(option!)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    //Mark: Button Actions
    
    @IBAction func switchButtonAction(_ sender: UISwitch) {
        
        if Reachability.isConnectedToNetwork(){
            
            let switchPoint:CGPoint = sender.convert(CGPoint.zero, to: self.optionsTableView)
            let indexPath:IndexPath = self.optionsTableView.indexPathForRow(at: switchPoint)!
            
            selectedIndexPath = indexPath
            
            let selectedOption = self.dataCtrl?.privacySettingOptionsArray[indexPath.row]
            selectedOption?.isSettingOn = selectedOption?.isSettingOn == "0" ? "1" :"0"
            
            self.dataCtrl?.selectedPrivacySettingOption = selectedOption
            
            self.setSelectedPrivacySetting()
            
        }else{
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Mark: Retry view delegate

    override func retryButtonClicked() {
        
    }
    
    //Mark: Set Settings
    
    func setSelectedPrivacySetting()
    {
        
        self.showTransperantLoadingOnViewController()
        
        self.dataCtrl?.setPrivacySettingOfUser(onSuccess: { [unowned self] (displayMessage) in
            
            DispatchQueue.main.async {
                
                self.removeTransperantLoadingFromViewController()
                
                let cell:PrivacySettingOptionTableViewCell =  self.optionsTableView.cellForRow(at: self.selectedIndexPath!) as! PrivacySettingOptionTableViewCell
                
                cell.loadCellWithOption( (self.dataCtrl?.selectedPrivacySettingOption!)!)
                
            }
            
            }, onFailure: { [unowned self] (errorMessage) in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    
                    //revert the selected changes
                    
                    self.dataCtrl?.selectedPrivacySettingOption?.isSettingOn = self.dataCtrl?.selectedPrivacySettingOption?.isSettingOn == "1" ? "0" : "1"
                    
                    let cell:PrivacySettingOptionTableViewCell =  self.optionsTableView.cellForRow(at: self.selectedIndexPath!) as! PrivacySettingOptionTableViewCell
                    
                    cell.loadCellWithOption( (self.dataCtrl?.selectedPrivacySettingOption!)!)
                    
                    let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
        })

    }
    

}
