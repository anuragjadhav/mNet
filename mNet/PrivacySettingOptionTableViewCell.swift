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
    
    
    func loadCellWithOption(_ option:SettingOption)  {
        
        self.optionNameLabel.text = option.settingOptionName
        
        if(option.isSettingOn! == "1"){
            
            self.switchButton.setOn(true, animated: true)
            //replase show word with hide to show proper description if switch id on
            let newDescriptionString:String = (option.settingOptionDescription?.replacingOccurrences(of: "Show", with: "Hide"))!
            self.optionDescriptionLabel.text = newDescriptionString
        }
        else{
            
            self.switchButton.setOn(false, animated: false)
            self.optionDescriptionLabel.text = option.settingOptionDescription
        }
    }
}
