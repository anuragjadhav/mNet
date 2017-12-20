//
//  CustomerBrownTextColorButton.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class CustomBrownTextColorButton: UIButton {

    override func awakeFromNib() {
        
        super.awakeFromNib();
        self.titleLabel?.textColor = ColorConstants.kBrownColor;
    }


}
