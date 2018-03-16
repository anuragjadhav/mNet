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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}
