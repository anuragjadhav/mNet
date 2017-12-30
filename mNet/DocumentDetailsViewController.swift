//
//  DocumentDetailsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class DocumentDetailsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var documentTypeLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentNoLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var meduimLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentAmountLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentDateLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var brandNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var expenseTypeLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var remarksLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var peopleListTableView: UITableView!
    @IBOutlet weak var peopleListTableViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        //TODO: remove this hardcoding
        self.peopleListTableViewHeightConstraint.constant = 3 * 50
        
        self.view.layoutIfNeeded()
    }
    
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PeopleListTableViewCell = tableView.dequeueReusableCell(withIdentifier:"PeopleListTableViewCell") as! PeopleListTableViewCell
        
        return cell
        
    }

    // MARK: - Button Actions

    @IBAction func approveButtonAction(_ sender: Any) {
        
    }

    @IBAction func rejectButtonAction(_ sender: Any) {
        
    }

}
