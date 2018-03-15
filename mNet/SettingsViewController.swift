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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var companyNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var groupsLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var applicationsLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var interactionsLabel: CustomBrownTextColorLabel!
    let dataCtrl = SettingsProfileDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    
        self.setupNavigationBar()
        
        self.getUserSettings()
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
         
            let resetPasswordVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
            resetPasswordVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    
            break
            
        case SettingOptions.privacySettings:
            
            let privacySettingsVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "PrivacySettingsViewController") as! PrivacySettingsViewController
            privacySettingsVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(privacySettingsVC, animated: true)
            break
            
        case SettingOptions.appSettings:
            
            let appSettingsVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "AppSettingsViewController")
            self.navigationController?.pushViewController(appSettingsVC, animated: true)
            break
            
        case SettingOptions.emailPreferences:
            
            let emailPreferenceVC = (UIStoryboard.init(name:"Settings", bundle: Bundle.main)).instantiateViewController(withIdentifier: "EmailPreferencesViewController") as! EmailPreferencesViewController
            emailPreferenceVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(emailPreferenceVC, animated: true)
            break
            
        case SettingOptions.groups:
           
            let peopleViewController:PeopleViewController = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.peopleViewController) as! PeopleViewController
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
        profileVC.dataCtrl.profile = self.dataCtrl.profile?.copy() as? Profile
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
                
                if(self.dataCtrl.profile?.firstName != nil && self.dataCtrl.profile?.lastName != nil)
                {
                    self.userNameLabel.text = (self.dataCtrl.profile?.firstName)! + " " + (self.dataCtrl.profile?.lastName)!
                }
                
                self.interactionsLabel.text = self.dataCtrl.profile?.profileVisitsCount
                self.companyNameLabel.text = self.dataCtrl.profile?.companyName
                self.applicationsLabel.text = self.dataCtrl.profile?.applicationCount
                self.groupsLabel.text = self.dataCtrl.profile?.groupCount
           
                if(self.dataCtrl.profile?.imageUrl != nil && self.dataCtrl.profile?.imageUrl != "")
                {
                    UIImage.imageDownloader.download((URLRequest.getRequest(self.dataCtrl.profile?.imageUrl))!) { response in
                        
                        if let image = response.result.value {
                            
                            self.profileImageView.image = image
                        }
                    }
                }
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
