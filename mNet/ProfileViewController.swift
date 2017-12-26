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
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar()
    }

    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
