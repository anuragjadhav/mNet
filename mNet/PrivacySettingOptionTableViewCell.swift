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
        
        self.optionNameLabel.text = option.settingOptionName
        self.optionDescriptionLabel.text = option.settingOptionDescription
        
        if(option.isSettingOn != nil){
            self.switchButton.setOn(option.isSettingOn!, animated: false)
        }
    }
}
