//
//  AppSettingsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class AppSettingsViewController: BaseViewController,UIPickerViewDelegate,UIPickerViewDataSource,CustomPickerViewDelegate {

    
    @IBOutlet weak var selectAppButton: CustomBrownTextColorButton!
    @IBOutlet weak var selectDefaultLandingPageButton: CustomBrownTextColorButton!
    @IBOutlet weak var hideActionButtonViewSummarySwitch: UISwitch!
    @IBOutlet weak var setupAmountInRoundFigureSwitch: UISwitch!
    @IBOutlet weak var setupAMountInWordsSwitch: UISwitch!
    
    let dataCtrl = SettingsDataController()
    var customerPickerView : CustomPickerView?
    
    var tempLandingPageArray:[String] = ["1 day","2 days","3 days","4 days"]
    var tempAppsArray:[String] = ["Approvals","Pending"]

    var isLandingPageButtonSelected: Bool = false
    var isAppsButtonSelected: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // add custom picker view
        self.customerPickerView = UINib(nibName: "CustomPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomPickerView
        self.customerPickerView?.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.size.width, height: (self.customerPickerView?.frame.size.height)!)
        self.view.addSubview(self.customerPickerView!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Picker View Delegates and Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(self.isLandingPageButtonSelected == true){
            
           return self.tempLandingPageArray.count
        }
        else if (self.isAppsButtonSelected == true){
            
            return self.tempAppsArray.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(self.isLandingPageButtonSelected == true){
            
            return self.tempLandingPageArray[row]
        }
        else if (self.isAppsButtonSelected == true){
            
            return self.tempAppsArray[row]
        }
        
        return ""
    }
    
    //Mark: Custom Picker View Delegate
    
    func selectedPickerViewIndex(index: Int) {
        
        if(self.isLandingPageButtonSelected == true){
            
            let selectedTitle = self.tempLandingPageArray[index]
            self.selectDefaultLandingPageButton.setTitle(selectedTitle, for:UIControlState.normal)

        }
        else if (self.isAppsButtonSelected == true){
            
            let selectedTitle = self.tempAppsArray[index]
            self.selectAppButton.setTitle(selectedTitle, for:UIControlState.normal)
        }
    
        //TODO:set selected object in data controller
    }
    
    //Mark: Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }

    @IBAction func selectAppsButtonAction(_ sender: Any) {
        
        isAppsButtonSelected = true
        isLandingPageButtonSelected = false
        
        self.customerPickerView?.showPickerView(isDatePicker: false, delegate: self)
        
    }
    
    @IBAction func defaultLandingPageButtonAction(_ sender: Any) {
        
        isAppsButtonSelected = false
        isLandingPageButtonSelected = true
        
        self.customerPickerView?.showPickerView(isDatePicker: false, delegate: self)

    }
}
