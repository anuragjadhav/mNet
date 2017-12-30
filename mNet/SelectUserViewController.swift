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

        // Do any additional setup after loading the view.
        setUpViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    func setUpViewController() {
        
        
    }
    
    //MARK: Button Actions
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
    }
    
    
    @IBAction func tickButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func selectUsersButtonAction(_ sender: UIButton) {
    }
}
