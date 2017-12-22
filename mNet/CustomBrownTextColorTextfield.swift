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
        self.textColor = ColorConstants.kBlueColor;
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}
