//
//  AttachmentsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class AttachmentsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var attachmentsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        attachmentsTableView.tableFooterView = UIView()
    }


    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AttachmentsTableViewCell = tableView.dequeueReusableCell(withIdentifier:"AttachmentsTableViewCell") as! AttachmentsTableViewCell
        
        return cell
        
    }

}
