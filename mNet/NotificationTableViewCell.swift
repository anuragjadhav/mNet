//
//  NotificationTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/19/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var readLabel: UILabel!
    @IBOutlet weak var messageLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    func loadCellWith(_ notification:NotificationObject)
    {
        messageLabel.text = notification.notificationMessage
        dateTimeLabel.text = notification.createdOn
        
        //set read unread background color
        if(notification.status == "1"){
            
            self.contentView.backgroundColor = UIColor.clear
        }
        else
        {
            self.contentView.backgroundColor = ColorConstants.kBackgroundColor
        }
    }
}
