//
//  CustomBrownTextColorTextfield.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

@IBDesignable
class CustomBrownTextColorTextfield: UITextField {

    @IBInspectable var inset: CGFloat = 0
    
    override func awakeFromNib() {
        
        super.awakeFromNib();
        self.textColor = ColorConstants.kBrownColor;
        let leftPaddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: inset, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = .always
    }
}
