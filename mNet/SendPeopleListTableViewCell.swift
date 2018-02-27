//
//  sendPeopleListTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SendPeopleListTableViewCell: UITableViewCell {

    @IBOutlet weak var personNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var personRoleLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var checkBoxButton: UIButton!

    @IBOutlet weak var checkBoxImageView: UIImageView!
    
    func setUpCell(user:ApprovalUser, isUserSelected:Bool) {
        
        personNameLabel.text = user.name
        personRoleLabel.text = user.designation
        
        if isUserSelected {
            checkBoxImageView.image = UIImage(named: ImageNames.checkBox)
        }
        else {
            checkBoxImageView.image = UIImage(named: ImageNames.unCheckBox)
        }
    }
}
