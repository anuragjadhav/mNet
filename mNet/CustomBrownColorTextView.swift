//
//  CustomBrownColorTextView.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/27/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class CustomBrownColorTextView: UITextView {

    override func awakeFromNib() {
        
        super.awakeFromNib();
        self.textColor = ColorConstants.kBrownColor;
    }
    

}
