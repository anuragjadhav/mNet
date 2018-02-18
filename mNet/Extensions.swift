//
//  Extensions.swift
//  mNet
//
//  Created by Nachiket Vaidya on 07/02/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func getWidthForfont(_ font:UIFont, forHeight height:CGFloat) -> CGFloat{
        
        let constrainedSize = CGSize(width: CGFloat(HUGE), height: height)
        let attributesDictionary = [
            NSAttributedStringKey.font : font
        ]
        
        let string = NSMutableAttributedString(string: self, attributes: attributesDictionary)
        let requiredWidth = string.boundingRect(with: constrainedSize, options: .usesLineFragmentOrigin, context: nil)
        return ceil(requiredWidth.size.width)
    }
    
    func getHeightForfont(_ font:UIFont, forWidth width:CGFloat) -> CGFloat{
        
        let constrainedSize = CGSize(width: width, height: CGFloat(HUGE))
        let attributesDictionary = [
            NSAttributedStringKey.font : font
        ]
        
        let string = NSMutableAttributedString(string: self, attributes: attributesDictionary)
        let requiredHeight = string.boundingRect(with: constrainedSize, options: .usesLineFragmentOrigin, context: nil)
        return ceil(requiredHeight.size.height)
    }
    
    func removeHTMLTags() -> String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)        
    }
}

extension Array
{
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


