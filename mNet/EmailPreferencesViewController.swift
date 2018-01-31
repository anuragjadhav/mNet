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
    
    let dataCtrl = SettingsProfileDataController()
    var customerPickerView : CustomPickerView?
    
    var tempDaysArray:[String] = ["1 day","2 days","3 days","4 days"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

       self.remindMebutton.titleLabel?.text = self.tempDaysArray[0]

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()

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
        
        return tempDaysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.tempDaysArray[row]
    }
    
    //Mark: Custom Picker View Delegate

    func selectedPickerViewIndex(index: Int) {
        
        let selectedTitle = self.tempDaysArray[index]
        
        self.remindMebutton.setTitle(selectedTitle, for:UIControlState.normal)
        
        //TODO:set selected object in data controller
    }
    
    //Mark: Button Actions
    
    @IBAction func remindMeButtonAction(_ sender: Any) {
        
        self.customerPickerView?.showPickerView(isDatePicker: false, delegate: self)
    }

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
