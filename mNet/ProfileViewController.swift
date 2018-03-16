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
        
        if(didComeFromPeopleVC)
        {
            self.getPeopleProfile()
        }
        else
        {
            self.setupProfileData()
        }
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
        
        if(didComeFromPeopleVC)
        {
            emailLabel.text = dataCtrl.profile?.email ?? "-"
        }
        else
        {
            emailLabel.text = User.loggedInUser()?.email ?? "-"
        }
        
        aboutLabel.text = dataCtrl.profile?.about ?? "-"
        addressLabel.text = dataCtrl.profile?.address ?? "-"
        landlineNumberLabel.text = dataCtrl.profile?.phoneNo ?? "-"
        mobileNumberLabel.text = dataCtrl.profile?.mobileNo ?? "-"
        designationLabel.text = dataCtrl.profile?.designation ?? "-"
        birthdayLabel.text = dataCtrl.profile?.dob ?? "----/--/--"
        
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

    //Mark: get people profile
    func getPeopleProfile(){
        
        self.showLoadingOnViewController()
        
        self.dataCtrl.getPeopleProfile(onSuccess: { [unowned self] in
            
            DispatchQueue.main.async {
                
                self.removeLoadingFromViewController()
                self.setupProfileData()
                
            }
            
            }, onFailure: { [unowned self] (errorMessage) in
                
                DispatchQueue.main.async {
                    self.removeLoadingFromViewController()
                    self.showRetryView(message:errorMessage)
                }
        })
    }

    
    //Mark: Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //Mark: Retry view delegate
    
    override func retryButtonClicked() {
        
        self.getPeopleProfile()
    }
    
}
