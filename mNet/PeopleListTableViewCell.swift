//
//  PeopleListTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PeopleListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var roleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var dateLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    func setUpCell(history:ApprovalHistory?) {
        
        if history == nil {
            return
        }
        nameLabel.text = history!.userName
        roleLabel.text = history!.approvalUserRole
        dateLabel.text = history!.createdOn.getDisplayFromtDateFromDateString()?.components(separatedBy: " ").first ?? history!.createdOn
        statusImageView.image = history!.statusImage
    }
}
