//
//  AppSettingsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class AppSettingsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //Mark: Button Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }

    @IBAction func selectAppsButtonAction(_ sender: Any) {
    }
    @IBAction func defaultLandingPageButtonAction(_ sender: Any) {
    }
}
