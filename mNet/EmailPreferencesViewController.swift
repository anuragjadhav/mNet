//
//  EmailPreferencesViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class EmailPreferencesViewController: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource,CustomPickerViewDelegate {
    
    @IBOutlet weak var conversationSettingsSwitch: UISwitch!
    @IBOutlet weak var approvalReminderSettingSwitch: UISwitch!
    @IBOutlet weak var commentsSettingSwitch: UISwitch!
    @IBOutlet weak var remindMebutton: CustomBrownTextColorButton!
    
    var dataCtrl:SettingsProfileDataController?
    var customerPickerView : CustomPickerView?
    
    var daysArray:[String] = ["1 day","2 days","3 days","4 days","5 day","6 days","7 days","8 days","9 day","10 days","11 days","12 days","13 day","14 days","15 days"]
    
    override func viewDidLoad() {
        
       super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
        
        //setup previous user settings
        remindMebutton.setTitle((dataCtrl?.settings?.reminderDays)! + " " + "days", for: .normal)
        
        if(dataCtrl?.settings?.postNotification == "1")
        {
           conversationSettingsSwitch.isOn = true
        }
        else
        {
            conversationSettingsSwitch.isOn = false
        }
        
        if(dataCtrl?.settings?.replyEmailNotification == "1")
        {
            approvalReminderSettingSwitch.isOn = true
        }
        else
        {
            approvalReminderSettingSwitch.isOn = false
        }
        
        if(dataCtrl?.settings?.postEmailNotification == "1")
        {
            commentsSettingSwitch.isOn = true
        }
        else
        {
            commentsSettingSwitch.isOn = false
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(self.customerPickerView == nil)
        {
            // add custom picker view
            self.customerPickerView = UINib(nibName: "CustomPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomPickerView
            self.customerPickerView?.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.size.width, height: (self.customerPickerView?.frame.size.height)!)
            self.view.addSubview(self.customerPickerView!)
        }
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Picker View Delegates and Data Source

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return daysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.daysArray[row]
    }
    
    //Mark: Custom Picker View Delegate

    func selectedPickerViewIndex(index: Int) {
        
        let selectedTitle:String = self.daysArray[index]
        
       let filterTitle1 = selectedTitle.replacingOccurrences(of: "days", with: "")
       let filterTitle2 = filterTitle1.replacingOccurrences(of: "day", with: "")
       let filterTitle3 = filterTitle2.replacingOccurrences(of: " ", with: "")
        
        
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            dataCtrl?.setEmailPreferenceSetting(conversationvalue:(dataCtrl?.settings?.postNotification)!,commentsvalue:(dataCtrl?.settings?.postEmailNotification)!,approvalvalue:(dataCtrl?.settings?.replyEmailNotification)!,remindDaysvalue:filterTitle3,onSuccess: { [unowned self] (displayMessage) in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    
                    self.remindMebutton.setTitle(selectedTitle, for: .normal)
                    
                    let alert = UIAlertController(title:AlertMessages.success, message:displayMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
   
                        let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
            })
            
        }else{
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Mark: Switch Button Actions
    
    @IBAction func conversationSwitchAction(_ sender: UISwitch) {
        
        let conversationValue:String = sender.isOn ? "1" : "0"
        
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            dataCtrl?.setEmailPreferenceSetting(conversationvalue:conversationValue,commentsvalue:(dataCtrl?.settings?.postEmailNotification)!,approvalvalue:(dataCtrl?.settings?.replyEmailNotification)!,remindDaysvalue:(dataCtrl?.settings?.reminderDays)!,onSuccess: { [unowned self] (displayMessage) in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    
                    let alert = UIAlertController(title:AlertMessages.success, message:displayMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        
                        //revert the selected changes
                        
                        self.conversationSettingsSwitch.isOn = sender.isOn ? false : true

                        let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
            })
            
        }else{
            
            self.conversationSettingsSwitch.isOn = sender.isOn ? false : true
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func approvalReminderSwitch(_ sender: UISwitch) {
        
        let approvalValue:String = sender.isOn ? "1" : "0"
        
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            dataCtrl?.setEmailPreferenceSetting(conversationvalue:(dataCtrl?.settings?.postNotification)!,commentsvalue:(dataCtrl?.settings?.postEmailNotification)!,approvalvalue:approvalValue,remindDaysvalue:(dataCtrl?.settings?.reminderDays)!,onSuccess: { [unowned self] (displayMessage) in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    
                    let alert = UIAlertController(title:AlertMessages.success, message:displayMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        
                        //revert the selected changes
                        
                        self.approvalReminderSettingSwitch.isOn = sender.isOn ? false : true
                        
                        let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
            })
            
        }else{
            
            self.approvalReminderSettingSwitch.isOn = sender.isOn ? false : true
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func commentsSwitchAction(_ sender: UISwitch) {
        
        let commentsValue:String = sender.isOn ? "1" : "0"
        
        if Reachability.isConnectedToNetwork(){
            
            self.showTransperantLoadingOnViewController()
            dataCtrl?.setEmailPreferenceSetting(conversationvalue:(dataCtrl?.settings?.postNotification)!,commentsvalue:commentsValue,approvalvalue:(dataCtrl?.settings?.replyEmailNotification)!,remindDaysvalue:(dataCtrl?.settings?.reminderDays)!,onSuccess: { [unowned self] (displayMessage) in
                
                DispatchQueue.main.async {
                    
                    self.removeTransperantLoadingFromViewController()
                    
                    let alert = UIAlertController(title:AlertMessages.success, message:displayMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                }, onFailure: { [unowned self] (errorMessage) in
                    
                    DispatchQueue.main.async {
                        
                        self.removeTransperantLoadingFromViewController()
                        
                        //revert the selected changes
                        
                        self.commentsSettingSwitch.isOn = sender.isOn ? false : true
                        
                        let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
            })
            
        }else{
            
            self.commentsSettingSwitch.isOn = sender.isOn ? false : true
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //Mark: Button Actions
    
    @IBAction func remindMeButtonAction(_ sender: Any) {
        
        self.customerPickerView?.showPickerView(isDatePicker: false, delegate: self)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
