//
//  AttachmentsTableTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/31/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class AttachmentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filenameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var dateLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    func setUpCell(fileNameString:String) {
        
        filenameLabel.text = fileNameString.components(separatedBy: "/").last ?? fileNameString
    }
}
