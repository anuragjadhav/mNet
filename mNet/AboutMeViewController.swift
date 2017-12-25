//
//  AboutMeViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class AboutMeViewController: BaseViewController,UITextFieldDelegate,CustomPickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: CustomBrownTextColorTextfield!
    @IBOutlet weak var genderButton: CustomBrownTextColorButton!
    @IBOutlet weak var birthdayButton: CustomBrownTextColorButton!
    
    @IBOutlet weak var designationTextfield: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var mobileNumberTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var landlineNumberTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var addressTextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var abouttextField: CustomBrownTextColorTextfield!
    
    @IBOutlet weak var emailIDTextField: CustomBrownTextColorTextfield!
    
    var customerPickerView : CustomPickerView?
    let dataCtrl = SettingsDataController()
    var genderArray:[String] = ["male","female"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add custom picker view
        self.customerPickerView = UINib(nibName: "CustomPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomPickerView
        self.customerPickerView?.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.size.width, height: (self.customerPickerView?.frame.size.height)!)
        self.view.addSubview(self.customerPickerView!)
        
        self.genderButton.titleLabel?.text = self.genderArray[0]
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
        
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.genderArray[row]
    }
    
    //Mark:Button Actions
    
    @IBAction func genderButtonAction(_ sender: Any) {
        
        self.customerPickerView?.showPickerView(isDatePicker: false, delegate: self)
    }
    
    
    @IBAction func birthdayButtonAction(_ sender: Any) {
        
      self.customerPickerView?.showPickerView(isDatePicker: true, delegate: self )
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    
    //Mark: Custom Picker Delegates
    
    func selectedPickerViewIndex(index: Int) {
        
        let selectedTitle = self.genderArray[index]
        
        self.genderButton.setTitle(selectedTitle, for:UIControlState.normal)
        
        //TODO:set selected object in data controller
    }

    func selectedDateOnPickerView(date: Date) {
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        
        let selectedDateInString = dateFormatter.string(from: date)
        
        self.birthdayButton.setTitle(selectedDateInString, for:UIControlState.normal)
        
        //TODO:set selected object in data controller
        
    }
    
}
