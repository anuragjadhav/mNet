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
    
    func loadCellWithUser(_ user:People)
    {
        var initials = user.userName?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + ($1 == "" ? "" : "\($1.first!)") }
        nameInitialsLabel.text = initials?.uppercased()
    }
}
