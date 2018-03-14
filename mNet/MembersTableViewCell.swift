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
        memberTypeLabel.text = member.memberType
        
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
