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
            memberTypeLabel.text = "To"
            memberTypeLabel.textColor = ColorConstants.kBrownColor

            if(member.askForAgree == "Yes")
            {
                if(member.agreeStatus == "Pending")
                {
                    memberTypeLabel.textColor = ColorConstants.kPendingActionColor
                    memberTypeLabel.text = "To Verify"
                }
                else if(member.agreeStatus == "Agreed")
                {
                    memberTypeLabel.text = "Verified"
                    memberTypeLabel.textColor = ColorConstants.kDoneActionColor
                }
                else
                {
                    memberTypeLabel.text = "Rejected"
                    memberTypeLabel.textColor = ColorConstants.kBeforeRejectionActionColor
                }
            }
            else if(member.askForApprove == "Yes")
            {
                if(member.agreeStatus == "Pending")
                {
                    memberTypeLabel.text = "To Approve"
                    memberTypeLabel.textColor = ColorConstants.kPendingActionColor
                }
                else if(member.agreeStatus == "Approved")
                {
                    memberTypeLabel.text = "Approved"
                    memberTypeLabel.textColor = ColorConstants.kDoneActionColor
                }
                else
                {
                    memberTypeLabel.text = "Rejected"
                    memberTypeLabel.textColor = ColorConstants.kBeforeRejectionActionColor
                }
            }
        }
        else if (member.memberType.lowercased() == "cc")
        {
            memberTypeLabel.text = "To"
            memberTypeLabel.textColor = ColorConstants.kBrownColor
        }
        else
        {
            memberTypeLabel.text = nil
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
