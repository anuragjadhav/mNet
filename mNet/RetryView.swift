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
    
    init(frame:CGRect,delegate:RetryViewProtocol) {
        super.init(frame: frame)
        self.delegate = delegate
        return
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func retryButtonAction(_
        sender: Any) {
        
        self.removeFromSuperview()
        
        if(delegate != nil){
            
            delegate?.retryButtonClicked()
        }
    }
}
