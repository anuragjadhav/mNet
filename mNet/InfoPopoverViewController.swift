//
//  InfoPopoverViewController.swift
//  mNet
//
//  Created by vishruta kadam on 27/03/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class InfoPopoverViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets and Properties
    
    @IBOutlet weak var popoverTableView: UITableView!
    var dataArray:[String] = [String]()
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup
    func setUp() {
        
        popoverTableView.tableFooterView = UIView()
        popoverTableView.estimatedRowHeight = 31
        popoverTableView.rowHeight = UITableViewAutomaticDimension
        popoverTableView.reloadData()
    }
    
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.popoverTableView)
        guard let textLabel:UILabel = cell?.viewWithTag(46) as? UILabel else {
            return cell!
        }
        textLabel.text = dataArray[indexPath.row]
        return cell!
    }
}
