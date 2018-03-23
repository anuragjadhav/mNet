//
//  MembersTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell {

    @IBOutlet weak var memberNameLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var memberTypeLabel: CustomBrownTextColorLabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    func loadCellWithMember(member:ConversationMember , isPostCreator:Bool)
    {
        memberNameLabel.text = member.userName
        
        if(member.askForAgree == "Yes")
        {
            if(member.agreeStatus == "Pending")
            {
                memberTypeLabel.text = "To Agree"
                memberTypeLabel.textColor = ColorConstants.kRedColor
            }
            else if(member.agreeStatus == "Agreed")
            {
                memberTypeLabel.text = "Agreed"
                memberTypeLabel.textColor = ColorConstants.kGreenColor
            }
            else
            {
                memberTypeLabel.text = "Disagreed"
                memberTypeLabel.textColor = ColorConstants.kGreenColor
            }
        }
        else if(member.askForApprove == "Yes")
        {
            if(member.agreeStatus == "Pending")
            {
                memberTypeLabel.text = "To Approve"
                memberTypeLabel.textColor = ColorConstants.kRedColor
            }
            else if(member.agreeStatus == "Approved")
            {
                memberTypeLabel.text = "Approved"
                memberTypeLabel.textColor = ColorConstants.kGreenColor
            }
            else
            {
                memberTypeLabel.text = "Rejected"
                memberTypeLabel.textColor = ColorConstants.kGreenColor
            }
        }
        else
        {
          memberTypeLabel.text = ""
        }
        
        
        if(isPostCreator)
        {
            deleteButton.isHidden = false
        }
        else
        {
            deleteButton.isHidden = true
        }
    }
}
