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
    
    @IBOutlet weak var vendorLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var mediumTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var meduimLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var documentAmountTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentAmountLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var documentDateTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var documentDateLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var descriptionLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var remarksLabel: CustomBrownTextColorLabel!
   
    @IBOutlet weak var costCentreLabel: CustomBrownTextColorLabel!
        
    @IBOutlet weak var peopleListTableView: FullLengthTableView!
    
    @IBOutlet weak var peopleContainerScrollView: UIScrollView!
    
    var dataController:ApprovalsDataController = ApprovalsDataController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setData()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.peopleContainerScrollView.flashScrollIndicators()
        }
    }
    
    func setData()  {
        
        peopleListTableView.estimatedRowHeight = 42
        peopleListTableView.rowHeight = UITableViewAutomaticDimension
        
        let approval:Approval? = dataController.selectedApproval
        
        documentTypeTitleLabel.text = approval?.documentTypeTitle ?? "Document Type"
        documentTypeLabel.text = approval?.documentTypeValue  ?? "-"
    
        documentNoTitleLabel.text = approval?.documentNumberTitle ?? "Document Number"
        documentNoLabel.text = approval?.documentNumberValue  ?? "-"
   
        mediumTitleLabel.text = approval?.mediumTitle ?? "Medium"
        meduimLabel.text = approval?.mediumValue  ?? "-"
    
        documentAmountTitleLabel.text = approval?.documentAmountTitle ?? "Document Amount"
        documentAmountLabel.text = approval?.documentAmountValue  ?? "-"
    
        documentDateTitleLabel.text = approval?.documentDateTitle ?? "Document Date"
        documentDateLabel.text = approval?.documentDateValue  ?? "-"
    
        vendorLabel.text = approval?.vendorValue  ?? "-"
        
        descriptionLabel.text = approval?.documentDescription
        remarksLabel.text = approval?.remarks
        costCentreLabel.text = approval?.costCentre
        
        peopleListTableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    //Mark: tableview delegates and data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.selectedApproval?.history.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PeopleListTableViewCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifiers.peopleListTableViewCell) as! PeopleListTableViewCell
        cell.setUpCell(history: dataController.selectedApproval?.history[safe:indexPath.row])
        return cell
        
    }

}
