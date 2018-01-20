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
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    
    let counts:[Int] = [1,3,1,3]
    let approvalLabels:[String] = ["Pending Approvals","Pending Verificationss","Completed Approvals","Completed Verifications"]
    let colors:[UIColor] = [ColorConstants.kBlueColor,ColorConstants.kBrownColor,ColorConstants.kBrownColor,ColorConstants.kBrownColor,]
    
    
    //MARK: View Controller Delegates
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

    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ApprovalSectionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.approvalsSectionsCollectionView, for: indexPath) as! ApprovalSectionCollectionViewCell
        
        cell.countLabel.text = "\(counts[indexPath.row])"
        cell.approvalsLabel.text = approvalLabels[indexPath.row]
        let color:UIColor = colors[indexPath.row]
        cell.countLabel.textColor = color
        cell.approvalsLabel.textColor = color
        
        return cell
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PendingApprovalsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.pendingApprovalsTableViewCell) as! PendingApprovalsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let documentVc = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentViewController")
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    //MARK: Button Actions

    @IBAction func backButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func approveButtonAction(_ sender: Any) {
        
        let documentVc = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ApprovalVerificationViewController")
        self.navigationController?.pushViewController(documentVc, animated: true)
    }

    @IBAction func rejectButtonAction(_ sender: Any) {
        
        let rejectApprovalVc = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "RejectApplicationViewController")
        self.navigationController?.pushViewController(rejectApprovalVc, animated: true)
    }
    
    @IBAction func attachmentButtonAction(_ sender: Any) {
        
        let documentVc = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentViewController")
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    //MARK: Button Actions
    
    @IBAction func filterButtonAction(_ sender: UIBarButtonItem) {
        
    }
    
    
}
