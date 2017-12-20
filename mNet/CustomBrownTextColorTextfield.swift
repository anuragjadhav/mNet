//
//  CustomBrownTextColorTextfield.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class CustomBrownTextColorTextfield: UITextField {

    override func awakeFromNib() {
        
        super.awakeFromNib();
        self.textColor = ColorConstants.kBlueColor;
    }
}
