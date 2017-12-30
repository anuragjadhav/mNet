//
//  ApprovalsViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ApprovalsViewController: BaseViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    //MARK:Outlets and Properties
    
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var sectionsCollectionView: UICollectionView!
    
    @IBOutlet weak var pendingApprovalsLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var pendingApprovalsTableView: UITableView!
    
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

    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.approvalsSectionsCollectionView, for: indexPath)
        return cell
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.pendingApprovalsTableViewCell)!
        return cell
    }
    
}
