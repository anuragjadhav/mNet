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
    @IBOutlet weak var approveButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var upArrowImageView: UIImageView!
    
    func setUpCell(approval:Approval, indexPath:IndexPath, buttonStatus:ApprovalStatus) {
        
        approveButton.tag = indexPath.row
        rejectButton.tag = indexPath.row
        attachmentButton.tag = indexPath.row
        
        switch buttonStatus {
        case .approve:
            approveButton.isHidden = false
            rejectButton.isHidden = false
            approveButton.setTitle(ConstantStrings.approve, for: .normal)
            approveButtonHeight.constant = 30
            buttonTopSpacing.constant = 15
        
        case .verify:
            approveButton.isHidden = false
            rejectButton.isHidden = false
            approveButton.setTitle(ConstantStrings.verify, for: .normal)
            approveButtonHeight.constant = 30
            buttonTopSpacing.constant = 15
        
        case .none:
            approveButton.isHidden = true
            rejectButton.isHidden = true
            approveButtonHeight.constant = 0
            buttonTopSpacing.constant = 0
        }
        
        
        //set up arrow image
        if(approval.postPriority == "0")
        {
            upArrowImageView.image = UIImage.init(named: "upArrowGray")
        }
        else if(approval.postPriority == "1")
        {
            upArrowImageView.image = UIImage.init(named: "upArrowBlue")
        }
        else
        {
            upArrowImageView.image = UIImage.init(named: "upArrowRed")
        }
        
        
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
