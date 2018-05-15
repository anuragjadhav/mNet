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
    
    func loadCellWithMember(member:ConversationMember , isPostCreator:Bool , postType:String)
    {
        memberNameLabel.text = member.userName
        
        if(member.askForAgree == "Yes")
        {
            if(member.agreeStatus == "Pending")
            {
                memberTypeLabel.text = "To Agree"
                
                if(postType == "5")
                {
                    memberTypeLabel.text = "To Verify"
                }
                
                memberTypeLabel.textColor = ColorConstants.kRedColor
            }
            else
            {
                memberTypeLabel.text = member.agreeStatus
                
                if(postType == "5" && member.agreeStatus == "Agree")
                {
                    memberTypeLabel.text = "Verify"
                }
                
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
            else
            {
                memberTypeLabel.text = member.agreeStatus
                memberTypeLabel.textColor = ColorConstants.kGreenColor
            }
        }
        else if(member.memberType == "Owner")
        {
          memberTypeLabel.text = "Creator"
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
