//
//  PendingApprovalsTableViewCell.swift
//  mNet
//
//  Created by Nachiket Vaidya on 14/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PendingApprovalsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var amountLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var brandTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var brandValueLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var mediumTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var mediumValueLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var vendorTitleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var vendorValueLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var attachmentButton: UIButton!
    
    func setUpCell(approval:Approval, indexPath:IndexPath) {
        
        approveButton.tag = indexPath.row
        rejectButton.tag = indexPath.row
        attachmentButton.tag = indexPath.row
        
        var title:String = approval.postTitle
        if let documentType:String = approval.documentType?.value {
            title = "\(title) (\(documentType))"
        }
        if let documentDate:String = approval.documentDate?.value {
            title = "\(title) | \(documentDate)"
        }
        titleLabel.text = title
        
        if let amount:String = approval.documentAmount?.value {
            amountLabel.text = "Rs. \(amount)"
        }
        else {
            amountLabel.text = "-"
        }
        
        let brandArray:[String] = approval.brand.removeHTMLTags().components(separatedBy: ":")
        if brandArray.count > 0 {
            if brandArray.count >  1 {
                brandTitleLabel.text = brandArray.first!.uppercased()
                brandValueLabel.text = brandArray[1]
            }
            else {
                brandTitleLabel.text = "BRAND"
                brandValueLabel.text = brandArray.first!
            }
        }
        else {
            brandTitleLabel.text = "BRAND"
            brandValueLabel.text = "-"
        }
        
        if let medium:DynamicData = approval.medium {
            mediumTitleLabel.text = medium.title
            mediumValueLabel.text = medium.value
        }
        else {
            mediumTitleLabel.text = "MEDIUM"
            mediumValueLabel.text = "-"
        }
        
        if let vendor:DynamicData = approval.vendor {
            vendorTitleLabel.text = vendor.title
            vendorValueLabel.text = vendor.value
        }
        else {
            vendorTitleLabel.text = "VENDOR"
            vendorValueLabel.text = "-"
        }
        
        attachmentButton.isHidden = approval.otherDocument.count <= 0        
        
    }
    
}
