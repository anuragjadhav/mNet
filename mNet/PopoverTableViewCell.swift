//
//  PopoverTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 15/04/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PopoverTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: CustomBrownTextColorLabel!
    
    func loadCellWith(popOverObject:PopoverObject)
    {
        label.text = popOverObject.title
        iconImageView.image = popOverObject.image ?? nil        
    }

}
