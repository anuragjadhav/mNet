//
//  AboutMeViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

struct TextFieldTags {
    
    static let name = 11
    static let designation = 12
    static let mobilenumber = 13
    static let landline = 14
    static let address = 15
    static let about = 16
    static let email = 17
}

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
    
     @IBOutlet weak var organizationTextField: CustomBrownTextColorTextfield!
     @IBOutlet weak var companyNameTextField: CustomBrownTextColorTextfield!
     @IBOutlet weak var branchTextField: CustomBrownTextColorTextfield!
     @IBOutlet weak var departmentTextField: CustomBrownTextColorTextfield!
    
    var customerPickerView : CustomPickerView?
    var genderArray:[String] = ["male","female"]
    
    let dataCtrl = AboutMeDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
        
        self.setupUserDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(self.customerPickerView == nil)
        {
            // add custom picker view
            self.customerPickerView = UINib(nibName: "CustomPickerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomPickerView
            self.customerPickerView?.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.size.width, height: (self.customerPickerView?.frame.size.height)!)
            self.view.addSubview(self.customerPickerView!)
            self.customerPickerView?.datePickerView.maximumDate = Date()
        }
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Setup user details
    
    func setupUserDetails()
    {
        if(dataCtrl.profile?.firstName != nil && dataCtrl.profile?.lastName != nil){
            nameTextField.text =  String(format:"%@ %@",(dataCtrl.profile?.firstName)!,(dataCtrl.profile?.lastName)!)
        }
        else{
            nameTextField.text = ""
        }
        
        if(User.loggedInUser()?.email != nil){
            emailIDTextField.text = User.loggedInUser()?.email
        }
        else{
            emailIDTextField.text = ""
        }
        
        abouttextField.text = dataCtrl.profile?.about ?? ""
        addressTextField.text = dataCtrl.profile?.address ?? ""
        landlineNumberTextField.text = dataCtrl.profile?.phoneNo ?? ""
        mobileNumberTextField.text = dataCtrl.profile?.mobileNo ?? ""
        designationTextfield.text = dataCtrl.profile?.designation ?? ""
        organizationTextField.text = dataCtrl.profile?.organizationName ?? ""
        companyNameTextField.text = dataCtrl.profile?.companyName ?? ""
        branchTextField.text = dataCtrl.profile?.branchName ?? ""
        departmentTextField.text = dataCtrl.profile?.department ?? ""
            
        if(dataCtrl.profile?.dob != nil && dataCtrl.profile?.dob != ""){
            
            //set selected date in picker view
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let selectedDate:Date = dateFormatter.date(from: (dataCtrl.profile?.dob)!)
                else {return}
            
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            dataCtrl.editedDob = dateFormatter.string(from:selectedDate)
            
            customerPickerView?.datePickerView.setDate(selectedDate, animated: true)
            
            birthdayButton.setTitle(dataCtrl.editedDob, for: .normal)

        }
        else{
            birthdayButton.setTitle("----/--/--", for: .normal)
        }
        
        if(dataCtrl.profile?.gender != nil){
            
            if(dataCtrl.profile?.gender! == "0")
            {
                genderButton.setTitle("male", for: .normal)
                dataCtrl.editedGender = "0"            }
            else
            {
                genderButton.setTitle("female", for: .normal)
                dataCtrl.editedGender = "1"
            }
        }
        else{
            genderButton.setTitle(genderArray[0], for: .normal)
            dataCtrl.editedGender = "0"
        }

    }
    
    
    //MARK: Textfield Delegates

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == TextFieldTags.mobilenumber
        {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        
        if textField.tag == TextFieldTags.landline
        {
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 11
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderColor = UIColor.lightGray.cgColor;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
        
        if Reachability.isConnectedToNetwork(){
            
            if(isAllDetailsValid())
            {
                //set data controller values
                var fullNameArray = nameTextField.text?.split(separator: " ")
                let firstName: String = String(fullNameArray![0])
                let lastName: String? = (fullNameArray?.count)! > 1 ? String(fullNameArray![1]) : ""
                
                dataCtrl.editedFirstName = firstName
                dataCtrl.editedLastName = lastName
                dataCtrl.editedAbout = abouttextField.text
                dataCtrl.editedDesignation = designationTextfield.text
                dataCtrl.editedAddress = addressTextField.text
                dataCtrl.editedPhoneNo = landlineNumberTextField.text
                dataCtrl.editedMobileNo = mobileNumberTextField.text

                self.showTransperantLoadingOnViewController()
                
                dataCtrl.updateUserDetails(onSuccess: { [unowned self] (displayMessage) in
                    
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
                        
                            let alert = UIAlertController(title:AlertMessages.failure, message:errorMessage, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                })
            }
            else
            {
                let alert = UIAlertController(title:AlertMessages.sorry, message:"Please enter valid details", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
        }else{
            
            let alert = UIAlertController(title:AlertMessages.failure, message:AlertMessages.networkUnavailable, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:AlertMessages.ok, style:.default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //Mark: Custom Picker Delegates
    
    func selectedPickerViewIndex(index: Int) {
        
        let selectedGender = self.genderArray[index]
        
        if(index == 0)
        {
            dataCtrl.editedGender = "0"
        }
        else
        {
            dataCtrl.editedGender = "1"
        }
        
        self.genderButton.setTitle(selectedGender, for:UIControlState.normal)
    }

    func selectedDateOnPickerView(date: Date) {
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let selectedDateInString = dateFormatter.string(from: date)
        
        self.birthdayButton.setTitle(selectedDateInString, for:UIControlState.normal)
        
        self.dataCtrl.editedDob = selectedDateInString
    }
    
    //Mark: Validations
    
    func isAllDetailsValid() -> Bool {
        
        var isDetailsValid:Bool = true
        
        if((nameTextField.text?.count)! < 5 || containsSpace(testStr: nameTextField.text!) == false)
        {
            isDetailsValid = false
            
            // set border to red to indicate invalid field
            nameTextField.layer.borderColor = (UIColor.red).cgColor
        }
        
        if((mobileNumberTextField.text?.count) != 10 )
        {
            isDetailsValid = false
            
            // set border to red to indicate invalid field
            mobileNumberTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        if((landlineNumberTextField.text?.count)! > 0 && (landlineNumberTextField.text?.count)! < 8)
        {
            isDetailsValid = false
            
            // set border to red to indicate invalid field
            landlineNumberTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        if((emailIDTextField.text?.count)! > 0 && isValidEmail(testStr: emailIDTextField.text!) == false)
        {
            isDetailsValid = false
            
            // set border to red to indicate invalid field
            emailIDTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        return isDetailsValid
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func containsSpace(testStr:String) -> Bool {
        
        let whitespace = NSCharacterSet.whitespaces
        let range = testStr.rangeOfCharacter(from:whitespace)
        
        // range will be nil if no whitespace is found
        if  range == nil {
            
            return false
        }
        else {
           
            return true
        }
    }
    
}
