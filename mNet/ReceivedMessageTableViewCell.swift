//
//  ReceivedMessageTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 1/11/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class ReceivedMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var linkTextView: UITextView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var linkViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var linkViewTopConstraint: NSLayoutConstraint!

    func loadCellWithConversationReply(reply:ConversationReply,link:String?)
    {
        //set time label
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //convert received string into date and then format it in required format
        let receivedDate = dateFormatter.date(from:reply.createdOn)
        dateFormatter.dateFormat = "h:mm a"
        
        let timeStringToSet = dateFormatter.string(from: receivedDate!)
        self.timeLabel.text = timeStringToSet
        
        //set namd and message
        userNameLabel.text = reply.fullName
        messageLabel.text = reply.replyMessage
        
        //set link if present
        if(link == nil || link == "")
        {
            linkViewTopConstraint.constant = 2
            linkViewHeightConstraint.constant = 0
            linkTextView.text = nil
        }
        else
        {
            linkTextView.text = link
            linkViewTopConstraint.constant = 8.5
            linkViewHeightConstraint.constant = 15
        }
        
        contentView.layoutIfNeeded()
    }

}
