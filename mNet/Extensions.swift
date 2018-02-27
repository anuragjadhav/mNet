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

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.classForCoder()) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

extension UIToolbar {
    
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.classForCoder()) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

