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
        
        if(member.memberType.lowercased() == "owner")
        {
            memberTypeLabel.text = "Creator"
            memberTypeLabel.textColor = ColorConstants.kBrownColor
        }
        else if (member.memberType.lowercased() == "bcc")
        {
            memberTypeLabel.text = "Bcc"
            memberTypeLabel.textColor = ColorConstants.kBrownColor
        }
        else if (member.memberType.lowercased() == "to")
        {
            if(member.askForAgree == "Yes")
            {
                if(member.agreeStatus == "Pending")
                {
                    memberTypeLabel.text = "To Verify"
                    memberTypeLabel.textColor = ColorConstants.kRedColor
                }
                else if(member.agreeStatus == "Agreed")
                {
                    memberTypeLabel.text = "Verified"
                    memberTypeLabel.textColor = ColorConstants.kGreenColor
                }
                else
                {
                    memberTypeLabel.text = "Rejected"
                    memberTypeLabel.textColor = ColorConstants.kGreenColor
                }
            }
            else if(member.askForAgree == "No" && member.askForApprove == "Yes")
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
                memberTypeLabel.text = nil
                memberTypeLabel.textColor = ColorConstants.kBrownColor
            }
        }
        else
        {
            memberTypeLabel.text = nil
            memberTypeLabel.textColor = ColorConstants.kBrownColor
        }
        
//        if(isPostCreator)
//        {
//            deleteButton.isHidden = false
//        }
//        else
//        {
//            deleteButton.isHidden = true
//        }
    }
}
