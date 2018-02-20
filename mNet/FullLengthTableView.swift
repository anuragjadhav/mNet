//
//  FullLengthTableView.swift
//  ECapex
//
//  Created by zeba on 21/03/17.
//  Copyright © 2017 UPL. All rights reserved.
//

import UIKit

class FullLengthTableView: UITableView {
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize : CGSize {
       
        self.layoutIfNeeded()
        
        let size = CGSize(width: UIViewNoIntrinsicMetric, height: self.contentSize.height)
        return size        
    }

}
