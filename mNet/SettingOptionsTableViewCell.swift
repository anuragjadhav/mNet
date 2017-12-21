//
//  SettingOptionsTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class SettingOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak private var  optionNameLabel: CustomBrownTextColorLabel!
    
    func loadCellWithOption(_ optionName:String) {
        
        self.optionNameLabel.text = optionName
    }

}
