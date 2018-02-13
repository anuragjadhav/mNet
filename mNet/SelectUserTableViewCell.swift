//
//  SelectUserTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 2/12/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class SelectUserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var designationLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    func loadCellWith(user:People,isSelected:Bool)
    {
        nameLabel.text = user.userName
        designationLabel.text = user.designation
        
        if(isSelected)
        {
            checkBoxButton.setImage(#imageLiteral(resourceName: "checkedBox"), for: .normal)
        }
        else
        {
            checkBoxButton.setImage(#imageLiteral(resourceName: "uncheckedBox"), for: .normal)
        }
    }
}
