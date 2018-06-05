//
//  RetryView.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/27/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

protocol RetryViewProtocol : class {
    
    func retryButtonClicked()
}

class RetryView: UIView {

    @IBOutlet weak var messageLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var retryButton: UIButton!
    
    weak var delegate:RetryViewProtocol?
    
    @IBOutlet weak var aquariumImageView: UIImageView!
    @IBOutlet weak var messageHorizontalCenterConstraint: NSLayoutConstraint!
    
    
    @IBAction func retryButtonAction(_
        sender: Any) {
        
        self.removeFromSuperview()
        
        if(delegate != nil){
            
            delegate?.retryButtonClicked()
        }
    }
}
