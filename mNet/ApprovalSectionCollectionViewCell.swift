//
//  ApprovalSectionCollectionViewCell.swift
//  mNet
//
//  Created by Nachiket Vaidya on 19/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ApprovalSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var approvalsLabel: CustomBlueTextColorLabel!
    
    func setUpCell(section: ApprovalSection, isTabSelected:Bool) {
        
        approvalsLabel.text = section.name
        countLabel.text = "\(section.tabCount)"
        
        if isTabSelected {
            approvalsLabel.textColor = ColorConstants.kBlueColor
            countLabel.textColor = ColorConstants.kBlueColor
        }
        else {
            approvalsLabel.textColor = ColorConstants.kBrownColor
            countLabel.textColor = ColorConstants.kBrownColor
        }
    }
}
