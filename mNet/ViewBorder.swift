//
//  ViewStoryboardColor.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/20/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ViewBorder: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
//    @IBInspectable var shadowColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.shadowColor!)
//        }
//        set {
//            layer.shadowColor = newValue?.cgColor
//        }
//    }
//    @IBInspectable var shadowOffset: CGSize? {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue!
//        }
//    }
//    @IBInspectable var shadowOpacity: Float? {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue!
//        }
//    }
//    
//    @IBInspectable var shadowRadius: CGFloat? {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue!
//        }
//    }
}
