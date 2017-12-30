//
//  CustomBlueBackgroundButton.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/30/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class CustomBlueBackgroundButton: UIButton {

    override func awakeFromNib() {
        
        super.awakeFromNib();
        self.titleLabel?.textColor = UIColor.white;
        self.backgroundColor = ColorConstants.kBlueColor
    }
}
