//
//  SelectedUsersCollectionViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 2/13/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class SelectedUsersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameInitialsLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    func loadCellWithUser(user:People,showDeleteButton:Bool)
    {
        let initials = user.userName?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + ($1 == "" ? "" : "\($1.first!)") }
        nameInitialsLabel.text = initials?.uppercased()
        
        if(showDeleteButton)
        {
            deleteButton.isHidden = false
        }
        else
        {
            deleteButton.isHidden = true
        }
    }
}
