//
//  ApprovalsViewController.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ApprovalsViewController: BaseViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, DateSelectorDeleagte {

    //MARK:Outlets and Properties
    
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var sectionsCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pendingApprovalsLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var pendingApprovalsTableView: UITableView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!

    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var filterLabelWidth: NSLayoutConstraint!
    var dataController:ApprovalsDataController = ApprovalsDataController()
    var isLoading:Bool = false
    
    @IBOutlet weak var noApprovalsLabel: CustomBrownTextColorLabel!
    
    var dashBoardVC:DashboardViewController?
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getData()
        setUpViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.setupNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        view.endEditing(true)
        self.navigationController?.navigationBar.showBottomHairline()
    }
    
    func setUpViewController() {
        
        pendingApprovalsTableView.estimatedRowHeight = 215
        pendingApprovalsTableView.rowHeight = UITableViewAutomaticDimension
        pendingApprovalsTableView.tableFooterView = UIView()
    }
    
    func setupNavigationBar(){
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.hideBottomHairline()
    }

    func getData() {
        
        searchBar.resignFirstResponder()
        self.retryView?.removeFromSuperview()
        
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
                self.checkNoData()
                
                switch self.dataController.filterString ?? "" {
                    
                case "1":   self.filterLabel.isHidden = false
                            self.filterLabel.text = "Today"
                
                case "2":   self.filterLabel.isHidden = false
                            self.filterLabel.text = "Past Week"
                    
                case "3":   self.filterLabel.isHidden = false
                            self.filterLabel.text = "Past Fifteen Days"
                    
                case "4":   self.filterLabel.isHidden = false
                            self.filterLabel.text = "Past Month"
                    
                case "5":   self.filterLabel.isHidden = false
                self.filterLabel.text = "\(self.dataController.startDate.shortDateFromDDMMYY()) to \(self.dataController.endDate.shortDateFromDDMMYY())"
                    
                default:    self.filterLabel.isHidden = true
                            self.filterLabel.text = ""
                    
                }
                
                self.filterLabelWidth.constant = (self.filterLabel.text ?? "").getWidthForfont(self.filterLabel.font, forHeight: 18) + 12
                
                self.removeTransperantLoadingFromViewController()
            }
            
        }) { (errorMessage) in
            
            DispatchQueue.main.async {
                
                self.removeTransperantLoadingFromViewController()
                self.showRetryView(message: errorMessage)
                self.isLoading = false
                self.checkNoData()
            }
        }
    }
    
    func checkNoData() {
        
        noApprovalsLabel.text = "No \(dataController.selectedSection?.name ?? "Approvals")"
        noApprovalsLabel.isHidden = (((dataController.selectedSection?.list.count) ?? 0) > 0)
    }
    
    func resetData() {
        
        dataController.reachedEnd = false
        dataController.searchValue = ""
        dataController.startIndex = 0
        dataController.filterString = nil
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
        
        let cell:ApprovalSectionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.approvalsSectionsCollectionViewCell, for: indexPath) as! ApprovalSectionCollectionViewCell
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
            cell.setUpCell(approval:approval, indexPath:indexPath, buttonStatus:dataController.selectedSection!.approvalStatus)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        dataController.selectedApprovalIndex = indexPath.row
        goToDetailsPage(preSelectedIndex: 0)
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
            dataController.reachedEnd = false
            getData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil && searchBar.text != dataController.searchValue {
            
            dataController.reachedEnd = false
            dataController.searchValue = searchBar.text!
            dataController.startIndex = 0
            dataController.reachedEnd = false
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
        
        dashBoardVC?.getDashboardStats()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func approveButtonAction(_ sender: UIButton) {
        
        dataController.selectedApprovalIndex = sender.tag
        let approvalVC:ApprovalVerificationViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "ApprovalVerificationViewController") as! ApprovalVerificationViewController
        approvalVC.dataController = dataController
        approvalVC.approvalsVC = self
        self.navigationController?.pushViewController(approvalVC, animated: true)
    }

    @IBAction func rejectButtonAction(_ sender: UIButton) {
        
        dataController.selectedApprovalIndex = sender.tag
        let rejectApprovalVc:RejectApplicationViewController = (UIStoryboard.init(name:"ApproveReject", bundle: Bundle.main)).instantiateViewController(withIdentifier: "RejectApplicationViewController") as! RejectApplicationViewController
        rejectApprovalVc.dataController = dataController
        rejectApprovalVc.approvalsVC = self
        self.navigationController?.pushViewController(rejectApprovalVc, animated: true)
    }
    
    @IBAction func attachmentButtonAction(_ sender: UIButton) {
        
        dataController.selectedApprovalIndex = sender.tag
        goToDetailsPage(preSelectedIndex: 1)
    }
    
    func goToDetailsPage(preSelectedIndex:Int) {
        
        let documentVc:DocumentViewController = UIStoryboard.approvals.instantiateViewController(withIdentifier: StoryboardIDs.approvalDetailsViewController) as! DocumentViewController
        documentVc.dataController = dataController
        documentVc.preSelectedSegment = preSelectedIndex
        documentVc.approvalsVC = self
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    @IBAction func filterButtonAction(_ sender: UIBarButtonItem) {
        
        showDateFilterPopUp()
    }
    
    func showDateFilterPopUp() {
        
        let dateFilter:DateSelectorViewController = UIStoryboard.dateSelector.instantiateViewController(withIdentifier: StoryboardIDs.dateFilterViewController) as! DateSelectorViewController
        dateFilter.delegate = self
        self.present(dateFilter, animated: false, completion: nil)
    }
    
    func didSelectDate(filterString: String?, fromDate: String?, toDate: String?) {
        
        dataController.filterString = filterString
        dataController.reachedEnd = false
        dataController.startIndex = 0
        dataController.startDate = fromDate ?? ""
        dataController.endDate = toDate ?? ""
        getData()
    }
    
}
