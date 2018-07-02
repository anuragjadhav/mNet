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
                    memberTypeLabel.textColor = hexStringToUIColor(hex:ColorConstants.kPendingActionColor)
                    memberTypeLabel.text = "To Verify"
                }
                else if(member.agreeStatus == "Agreed")
                {
                    memberTypeLabel.text = "Verified"
                    memberTypeLabel.textColor = hexStringToUIColor(hex:ColorConstants.kDoneActionColor)
                }
                else
                {
                    memberTypeLabel.text = "Rejected"
                    memberTypeLabel.textColor = hexStringToUIColor(hex:ColorConstants.kBeforeRejectionActionColor)
                }
            }
            else if(member.askForApprove == "Yes")
            {
                if(member.approveStatus == "Pending")
                {
                    memberTypeLabel.text = "To Approve"
                    memberTypeLabel.textColor = hexStringToUIColor(hex:ColorConstants.kPendingActionColor)
                }
                else if(member.approveStatus == "Approved")
                {
                    memberTypeLabel.text = "Approved"
                    memberTypeLabel.textColor = hexStringToUIColor(hex:ColorConstants.kDoneActionColor)
                }
                else
                {
                    memberTypeLabel.text = "Rejected"
                    memberTypeLabel.textColor = hexStringToUIColor(hex:ColorConstants.kBeforeRejectionActionColor)
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
    
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
