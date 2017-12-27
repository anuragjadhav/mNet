//
//  RejectApplicationViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class RejectApplicationViewController: BaseViewController {

    @IBOutlet weak var messageTextView: CustomBrownColorTextView!
    
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
  
    // MARK: - Button Actions

    @IBAction func rejectButtonAction(_ sender: Any) {
    }

    @IBAction func backButtonAction(_ sender: Any) {
    }
    

}
