//
//  ConversationInfoViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 31/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationInfoViewController: BaseViewController {

    //MARK: Outlets and Properties
    @IBOutlet weak var user1Label: CustomBrownTextColorLabel!
    
    @IBOutlet weak var user2Label: CustomBrownTextColorLabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    @IBOutlet weak var membersLabel: CustomBlueTextColorLabel!
    
    @IBOutlet weak var membersTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    func setUpViewController()  {
        
        
    }
}
