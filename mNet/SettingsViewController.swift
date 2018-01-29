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

    let dataCtrl = SettingsProfileDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    
        self.setupNavigationBar()
    }

    func setupNavigationBar(){
        
        guard let baseNavigationController:BaseNavigationController = self.navigationController as? BaseNavigationController else {
            return
        }
        baseNavigationController.showLargeTitles()
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
            
            let aboutMeVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "AboutMeViewController") as! AboutMeViewController
            aboutMeVC.dataCtrl.profile = self.dataCtrl.profile
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
           
            let peopleViewController:PeopleViewController = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.peopleViewController) as! PeopleViewController
            peopleViewController.isForGroups = true
            self.navigationController?.pushViewController(peopleViewController, animated: true)
            break;
        
        case SettingOptions.people:
            
            let peopleViewController:PeopleViewController = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.peopleViewController) as! PeopleViewController
            self.navigationController?.pushViewController(peopleViewController, animated: true)
            break;
        
        default: break
            
        }
    }
    
    //Mark: Button Actions

    @IBAction func gotoButtonAction(_ sender: Any) {
        
        let profileVC = (UIStoryboard.init(name:"Profile", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.dataCtrl?.profile = self.dataCtrl.profile
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
        
    //Mark: Get Settings And Profile
    
    func getUserSettings(){
        
        if Reachability.isConnectedToNetwork(){
            
            self.showLoadingOnViewController()
            
            self.dataCtrl.getSettingOfUser(onSuccess: { [unowned self] in
                
                DispatchQueue.main.async {
                    self.getUserProfile()
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        self.removeLoadingFromViewController()
                        self.showRetryView(message:errorMessage)
                    }
            })
            
        }else{
            
            self.showRetryView(message: AlertMessages.networkUnavailable)
        }
    }
    
    func getUserProfile(){
        
        self.dataCtrl.getUserProfile(onSuccess: { [unowned self] in
            
            DispatchQueue.main.async {
                self.removeLoadingFromViewController()
                
                //TODO: set profile picture , company name and groups interactions value
            }
            
            }, onFailure: { [unowned self] (errorMessage) in
                
                DispatchQueue.main.async {
                    self.removeLoadingFromViewController()
                    self.showRetryView(message:errorMessage)
                }
        })
    }

    //Mark: Retry view delegate
    
    override func retryButtonClicked() {
        
        self.getUserSettings()
    }
    
}
