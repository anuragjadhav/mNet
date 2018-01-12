//
//  CustomRedBackgroundColorButton.swift
//  mNet
//
//  Created by Nachiket Vaidya on 11/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class CustomRedBackgroundColorButton: UIButton {
    
    override func awakeFromNib() {
        
        super.awakeFromNib();
        self.titleLabel?.textColor = UIColor.white;
        self.backgroundColor = ColorConstants.kRedColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.24
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
    }
}
