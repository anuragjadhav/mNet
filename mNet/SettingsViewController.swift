//
//  SettingsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/19/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var profileBackgroundView: UIView!

    let dataCtrl = SettingsDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileBackgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(profileBackgroundViewClicked(gesture:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }

    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataCtrl.settingOptionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SettingOptionsTableViewCell = tableView.dequeueReusableCell(withIdentifier:"SettingOptionsTableViewCell") as! SettingOptionsTableViewCell
        
        let optionName = self.dataCtrl.settingOptionsArray[indexPath.row]
        
        cell.loadCellWithOption(optionName)
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let optionName = self.dataCtrl.settingOptionsArray[indexPath.row]
        
        switch optionName {
            
        case SettingOptions.aboutMe:
            
            let aboutMeVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "AboutMeViewController")
            self.navigationController?.pushViewController(aboutMeVC, animated: true)
            break
            
        case SettingOptions.password:
         
            //TODO
            break
            
        case SettingOptions.privacySettings:
            
            let privacySettingsVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "PrivacySettingsViewController")
            self.navigationController?.pushViewController(privacySettingsVC, animated: true)
            break
            
        case SettingOptions.appSettings:
            
            let appSettingsVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "AppSettingsViewController")
            self.navigationController?.pushViewController(appSettingsVC, animated: true)
            break
            
        case SettingOptions.emailPreferences:
            
            let emailPreferenceVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "EmailPreferencesViewController")
            self.navigationController?.pushViewController(emailPreferenceVC, animated: true)
            break
            
        case SettingOptions.groups:
           
            //TODO :
            break;
            
        default: break
            
        }
    }
    
    
    //MARK: Gesture recognizer methods
    
    func profileBackgroundViewClicked(gesture:UITapGestureRecognizer){
        
        let profileVC = (UIStoryboard.init(name:"Profile", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ProfileViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    //Mark: Button Actions

    
}
