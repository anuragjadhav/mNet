//
//  SelectUserViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SelectUserViewController: BaseViewController {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var toLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var userListTableView: UITableView!
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tickBarButton: UIBarButtonItem!
    
    @IBOutlet weak var selectUsersLabel: CustomBlueTextColorLabel!
    
    @IBOutlet weak var selectUsersButton: UIButton!
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpNavigationController()
    }
    
    //MARK: Setup
    func setUpNavigationController() {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Button Actions
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func tickButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func selectUsersButtonAction(_ sender: UIButton) {
        
    }
}
