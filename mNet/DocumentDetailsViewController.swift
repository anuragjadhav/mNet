//
//  DocumentDetailsViewController.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class DocumentDetailsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var documentTypeTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentTypeLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var documentNoTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentNoLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var mediumTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var meduimLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var documentAmountTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentAmountLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var documentDateTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentDateLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var brandTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var brandNameLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var vendorBrandTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var vendorBrandNameLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var expenseTypeLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var remarksLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var peopleListTableView: FullLengthTableView!
    
    var dataController:ApprovalsDataController = ApprovalsDataController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    func setData()  {
        
        peopleListTableView.estimatedRowHeight = 42
        peopleListTableView.rowHeight = UITableViewAutomaticDimension
        
        let approval:Approval? = dataController.selectedApproval
        
        if let documentType:DynamicData = approval?.documentType {
            documentTypeTitleLabel.text = documentType.title
            documentTypeLabel.text = documentType.value
        }
        else {
            documentTypeTitleLabel.text = "Document Type"
            documentTypeLabel.text = "-"
        }
        
        if let documentNumber:DynamicData = approval?.documentNumber {
            documentNoTitleLabel.text = documentNumber.title
            documentNoLabel.text = documentNumber.value
        }
        else {
            documentNoTitleLabel.text = "Document Number"
            documentNoLabel.text = "-"
        }
        
        if let medium:DynamicData = approval?.medium {
            mediumTitleLabel.text = medium.title
            meduimLabel.text = medium.value
        }
        else {
            mediumTitleLabel.text = "Medium"
            meduimLabel.text = "-"
        }
        
        if let documentAmount:DynamicData = approval?.documentAmount {
            documentAmountTitleLabel.text = documentAmount.title
            documentAmountLabel.text = documentAmount.value
        }
        else {
            documentAmountTitleLabel.text = "Document Amount"
            documentAmountLabel.text = "-"
        }
        
        if let documentDate:DynamicData = approval?.documentDate {
            documentDateTitleLabel.text = documentDate.title
            documentDateLabel.text = documentDate.value
        }
        else {
            documentDateTitleLabel.text = "Document Date"
            documentDateLabel.text = "-"
        }
        
        if let vendor:DynamicData = approval?.vendor {
            vendorBrandNameLabel.text = vendor.value
        }
        else {
            vendorBrandNameLabel.text = "-"
        }
        
        peopleListTableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    //Mark: tableview delegates and data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.selectedApproval?.history.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PeopleListTableViewCell = tableView.dequeueReusableCell(withIdentifier:"PeopleListTableViewCell") as! PeopleListTableViewCell
        cell.setUpCell(history: dataController.selectedApproval?.history[safe:indexPath.row])
        return cell
        
    }

}
