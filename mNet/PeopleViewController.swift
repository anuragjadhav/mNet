//
//  PeopleViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/28/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var peopleTableView: UITableView!
    
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
    
    //Mark: tableview delegates and data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PeopleTableViewCell = tableView.dequeueReusableCell(withIdentifier:"PeopleTableViewCell") as! PeopleTableViewCell
        
        return cell
        
    }

    // MARK: - Search bar delegates
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //TODO
    }
    
    // MARK: - Button Actions

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
