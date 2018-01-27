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
    
    let dataCtrl = SettingsDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        optionsTableView.estimatedRowHeight = 73
        optionsTableView.rowHeight = UITableViewAutomaticDimension
        
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
        
        return self.dataCtrl.privacySettingOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PrivacySettingOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier:"PrivacySettingOptionTableViewCell") as! PrivacySettingOptionTableViewCell
        
        let option = self.dataCtrl.privacySettingOptionsArray[indexPath.row]
        
        cell.loadCellWithOption(option)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    //Mark: Get Settings
    func getPrivacySettings(){
        
        if Reachability.isConnectedToNetwork(){
            
            self.showLoadingOnViewController()
            
            self.dataCtrl.getPrivacySettingOfUser(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    
                    self.removeLoadingFromViewController()
                    self.optionsTableView.reloadData()
                    
                }
                
            }, onFailure: { [unowned self] (displayMessage) in
                
                self.removeLoadingFromViewController()
                self.showRetryView(message:displayMessage)
            })

        }else{
            
           self.showRetryView(message: AlertMessages.networkUnavailable)
        }
    }
    
    //Mark: Button Actions
    
    @IBAction func switchButtonAction(_ sender: UISwitch) {
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Mark: Retry view delegate

    override func retryButtonClicked() {
        
        self.getPrivacySettings()
    }

}
