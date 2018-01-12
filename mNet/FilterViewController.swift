//
//  FilterViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 11/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets and properties
    
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet weak var clearBarButton: UIBarButtonItem!
    @IBOutlet weak var conversationsLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var filterSectionsTableView: UITableView!
    @IBOutlet weak var filterOptionsTableView: UITableView!
    
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
        
        filterSectionsTableView.tableFooterView = UIView()
        filterOptionsTableView.tableFooterView = UIView()
        
        filterSectionsTableView.layer.shadowColor = UIColor.black.cgColor
        filterSectionsTableView.layer.shadowOffset = CGSize(width: 4, height: -4)
        filterSectionsTableView.layer.shadowOpacity = 0.14
        filterSectionsTableView.layer.shadowRadius = 2.0
        filterSectionsTableView.layer.masksToBounds = false
    }
    
    //MARK:Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == filterSectionsTableView {
            
            return 5
        }
        
        else {
            
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == filterSectionsTableView {
            
            let cell:FilterSectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.filterTableViewCell) as! FilterSectionTableViewCell
            return cell
        }
        
        else {
            
            let cell:FilterOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.optionTableViewCell) as! FilterOptionTableViewCell
            return cell
        }
    }
    
    
    //MARK:Button Actions
    
    @IBAction func backBarButtonAction(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearBarButtonAction(_ sender: UIBarButtonItem) {
    }
    
    
}
