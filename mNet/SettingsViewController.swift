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
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveAnyPushNotification), name:.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.tabBarController?.tabBar.isHidden = false
    
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
        
        let cell:SettingOptionsTableViewCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifiers.settingOptionsTableViewCell) as! SettingOptionsTableViewCell
        
        let optionName = self.dataCtrl.settingOptionsArray[indexPath.row]
        
        cell.loadCellWithOption(optionName)
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let optionName = self.dataCtrl.settingOptionsArray[indexPath.row]
        
        switch optionName {
            
        case SettingOptions.aboutMe:
            
            let aboutMeVC = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.aboutMeViewController) as! AboutMeViewController
            aboutMeVC.dataCtrl.profile = self.dataCtrl.profile
            self.navigationController?.pushViewController(aboutMeVC, animated: true)
            break
            
        case SettingOptions.password:
         
            let resetPasswordVC = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.resetPasswordViewController) as! ResetPasswordViewController
            resetPasswordVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    
            break
            
        case SettingOptions.privacySettings:
            
            let privacySettingsVC = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.privacySetingsViewController) as! PrivacySettingsViewController
            privacySettingsVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(privacySettingsVC, animated: true)
            break
            
        case SettingOptions.appSettings:
            
            let appSettingsVC = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.appSettingsViewController)
            self.navigationController?.pushViewController(appSettingsVC, animated: true)
            break
            
        case SettingOptions.emailPreferences:
            
            let emailPreferenceVC = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.emailPreferencesViewController) as! EmailPreferencesViewController
            emailPreferenceVC.dataCtrl = self.dataCtrl
            self.navigationController?.pushViewController(emailPreferenceVC, animated: true)
            break
            
        case SettingOptions.blockedUsers:
           
            let blockedUsersViewController:BlockedUsersViewController = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.blockedUsersViewController) as! BlockedUsersViewController
            self.navigationController?.pushViewController(blockedUsersViewController, animated: true)
            break;
        
        case SettingOptions.people:
            
            let peopleViewController:PeopleViewController = UIStoryboard.settings.instantiateViewController(withIdentifier: StoryboardIDs.peopleViewController) as! PeopleViewController
            self.navigationController?.pushViewController(peopleViewController, animated: true)
            break;
            
        case SettingOptions.logout:
            
            let alert = UIAlertController(title:"Are you sure you want to logout?", message:nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Cancel", style:.cancel, handler: { _ in
            }))
            alert.addAction(UIAlertAction(title:"Log Out", style:.destructive, handler: { _ in
                self.logout()
            }))
            
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
            break;
        
        default: break
            
        }
    }
    
    //MARK: Push Notification
    
    @objc func didReceiveAnyPushNotification()
    {
        let didReceivePusnNotif:Bool = UserDefaults.standard.bool(forKey: UserDefaultsKeys.didReceiveNotification)
        
        if didReceivePusnNotif == true {
            
            self.tabBarController?.selectedIndex = 2
        }
        
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.didReceiveNotification)
        UserDefaults.standard.synchronize()
    }
    
    //MARK: Button Actions

    @IBAction func gotoButtonAction(_ sender: Any) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let profileVC = UIStoryboard.profile.instantiateViewController(withIdentifier: StoryboardIDs.profileViewController) as! ProfileViewController
        profileVC.dataCtrl.profile = self.dataCtrl.profile?.copy() as? Profile
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
        
    //MARK: Get Settings And Profile
    
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
                   if let urlRequest:URLRequest = URLRequest.getRequest(URLS.imageBaseURLString + (self.dataCtrl.profile?.imageUrl)!)
                    {
                        UIImage.imageDownloader.download(urlRequest) { response in
                            
                            if let image = response.result.value {
                                
                                self.profileImageView.image = image
                            }
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

    //MARK: Retry view delegate
    
    override func retryButtonClicked() {
        
        self.getUserSettings()
    }
    
    //MARK: Logout
    
    func logout(){
        
        self.showTransperantLoadingOnViewController()
        
        self.dataCtrl.deRegisterDeviceToken(onSuccess: { [unowned self] in
            DispatchQueue.main.async {
                self.removeTransperantLoadingFromViewController()
                AppDelegate.sharedInstance.logout()
            }
            }, onFailure: { [unowned self]  in
                
                DispatchQueue.main.async {
                    self.removeTransperantLoadingFromViewController()
                    let alert = UIAlertController(title:AlertMessages.sorry, message:"Unable to logout", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                    self.present(alert, animated: false, completion: nil)
              }
        })
    }
}
