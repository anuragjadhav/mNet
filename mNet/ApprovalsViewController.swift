//
//  ApprovalsViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ApprovalsViewController: BaseViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //MARK:Outlets and Properties
    
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var sectionsCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pendingApprovalsLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var pendingApprovalsTableView: UITableView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!

    var dataController:ApprovalsDataController = ApprovalsDataController()
    var isLoading:Bool = false
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
        self.getData()
    }
    
    func setUpViewController() {
        
        pendingApprovalsTableView.tableFooterView = UIView()
        pendingApprovalsTableView.estimatedRowHeight = 215
        pendingApprovalsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
    }

    func getData() {
        
        searchBar.resignFirstResponder()
        
        if isLoading || dataController.reachedEnd {
            return
        }
        
        if dataController.startIndex == 0 {
            showTransperantLoadingOnViewController()
        }
        
        isLoading = true
        
        dataController.getApprovalsData(onSuccess: { 
            
            DispatchQueue.main.async {
                
                self.sectionsCollectionView.reloadData()
                self.pendingApprovalsTableView.reloadData()
                self.pendingApprovalsLabel.text = self.dataController.selectedSection?.name
                self.isLoading = false
                self.removeTransperantLoadingFromViewController()
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                
                self.removeTransperantLoadingFromViewController()
                self.showRetryView(message: errorMessage)
                self.isLoading = false
            }
        }
    }
    
    func resetData() {
        
        dataController.reachedEnd = false
        dataController.searchValue = ""
        dataController.startIndex = 0
        searchBar.text = ""
    }
    
    override func retryButtonClicked() {
        resetData()
        getData()
    }
    
    //MARK: Collection View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataController.approvalsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ApprovalSectionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.approvalsSectionsCollectionView, for: indexPath) as! ApprovalSectionCollectionViewCell
        if let section:ApprovalSection = dataController.approvalsData[safe:indexPath.row] {
            cell.setUpCell(section: section, isTabSelected: dataController.selectedSectionIndex == indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        dataController.selectedSectionIndex = indexPath.row
        resetData()
        getData()
    }
    
    //MARK: Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.selectedSection?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PendingApprovalsTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.pendingApprovalsTableViewCell) as! PendingApprovalsTableViewCell
        if let approval:Approval = dataController.selectedSection?.list[safe:indexPath.row] {
            cell.setUpCell(approval: approval, indexPath: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dataController.selectedApprovalIndex = indexPath.row
        let documentVc:DocumentViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        documentVc.dataController = dataController
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == pendingApprovalsTableView {
            
            let contentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
            
            if maximumOffset - contentOffset <= 100 {
                
                getData()
            }
        }
    }
    
    
    //MARK: Search Bar Delegates
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil && searchBar.text != dataController.searchValue {
            
            dataController.reachedEnd = false
            dataController.searchValue = searchBar.text!
            dataController.startIndex = 0
            getData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil && searchBar.text != dataController.searchValue {
            
            dataController.reachedEnd = false
            dataController.searchValue = searchBar.text!
            dataController.startIndex = 0
            getData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" {
            
            dataController.reachedEnd = false
            dataController.searchValue = ""
            dataController.startIndex = 0
            getData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        resetData()
        getData()
    }
    
    
    //MARK: Button Actions
    @IBAction func backButtonAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
        
        dataController.selectedApprovalIndex = sender.tag
        let approvalVC:ApprovalVerificationViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ApprovalVerificationViewController") as! ApprovalVerificationViewController
        
        self.navigationController?.pushViewController(approvalVC, animated: true)
    }

    @IBAction func rejectButtonAction(_ sender: UIButton) {
        
        dataController.selectedApprovalIndex = sender.tag
        let rejectApprovalVc:RejectApplicationViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "RejectApplicationViewController") as! RejectApplicationViewController
        rejectApprovalVc.dataController = dataController
        self.navigationController?.pushViewController(rejectApprovalVc, animated: true)
    }
    
    @IBAction func attachmentButtonAction(_ sender: UIButton) {
        
        dataController.selectedApprovalIndex = sender.tag
        let documentVc:DocumentViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
        documentVc.dataController = dataController
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    
    @IBAction func filterButtonAction(_ sender: UIBarButtonItem) {
        
    }
    
    
}
