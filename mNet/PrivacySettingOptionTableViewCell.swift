//
//  PrivacySettingOptionTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/21/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PrivacySettingOptionTableViewCell: UITableViewCell {

    @IBOutlet weak private var optionNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak private var optionDescriptionLabel: CustomBrownTextColorLabel!
    @IBOutlet weak public private(set) var switchButton: UISwitch!
    
    
    func loadCellWithOption(_ option:Option)  {
        
        self.optionNameLabel.text = option.optionName
        self.optionDescriptionLabel.text = option.optionDescription
        
        if(option.isOn != nil){
            self.switchButton.setOn(option.isOn!, animated: false)
        }
    }
}
