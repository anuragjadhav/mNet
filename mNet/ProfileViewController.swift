//
//  ProfileViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/26/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var emailLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var aboutLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var addressLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var landlineNumberLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var mobileNumberLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var designationLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var birthdayLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var genderLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var nameLabel: CustomBrownTextColorLabel!
    
    let dataCtrl:ProfileDataController = ProfileDataController()
    var didComeFromPeopleVC:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
        
        self.setupProfileData()
    }

    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: setup profile data
    
    func setupProfileData()
    {
        if(dataCtrl.profile?.firstName != nil && dataCtrl.profile?.lastName != nil){
            nameLabel.text =  String(format:"%@ %@",(dataCtrl.profile?.firstName)!,(dataCtrl.profile?.lastName)!)
        }
        else{
            nameLabel.text = "-"
        }
        
        if(User.loggedInUser()?.email != nil){
            emailLabel.text = User.loggedInUser()?.email
        }
        else{
             emailLabel.text = "-"
        }
        
        if(dataCtrl.profile?.about != nil){
            aboutLabel.text = dataCtrl.profile?.about
        }
        else{
            aboutLabel.text = "-"
        }
        
        if(dataCtrl.profile?.address != nil){
            addressLabel.text = dataCtrl.profile?.address
        }
        else{
            addressLabel.text = "-"
        }
        
        if(dataCtrl.profile?.phoneNo != nil){
            landlineNumberLabel.text = dataCtrl.profile?.phoneNo
        }
        else{
            landlineNumberLabel.text = "-"
        }
        
        if(dataCtrl.profile?.mobileNo != nil){
            mobileNumberLabel.text = dataCtrl.profile?.mobileNo
        }
        else{
            mobileNumberLabel.text = "-"
        }
        
        if(dataCtrl.profile?.designation != nil){
            designationLabel.text = dataCtrl.profile?.designation
        }
        else{
            designationLabel.text = "-"
        }
        
        if(dataCtrl.profile?.dob != nil){
            birthdayLabel.text = dataCtrl.profile?.dob
        }
        else{
            birthdayLabel.text = "----/--/--"
        }
        
        if(dataCtrl.profile?.gender != nil){
            
            if(dataCtrl.profile?.gender! == "0")
            {
                genderLabel.text = "male"
            }
            else
            {
                genderLabel.text = "female"
            }
        }
        else{
            genderLabel.text = "-"
        }
    }

    
    //Mark: Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
