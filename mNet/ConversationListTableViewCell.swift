//
//  ConversationListTableViewCell.swift
//  mNet
//
//  Created by Nachiket Vaidya on 30/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class ConversationListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameInitialsLabel: UILabel!
    @IBOutlet weak var nameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func loadCellWithConversation(conversation:Conversation) {
        
        self.profileImageView.isHidden = true
        
        //set name initials and name label
        let initials = conversation.latestReplierName.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + ($1 == "" ? "" : "\($1.first!)") }
        nameInitialsLabel.text = initials.uppercased()
        nameLabel.text = conversation.latestReplierName
        
//        //removed extra spaces in string
//        var imageUrlString = conversation.latesReplierImage?.components(separatedBy: .whitespaces).joined()
//
//        if(imageUrlString == nil)
//        {
//            imageUrlString = ""
//        }
//
//        //if profile image not found then make image nil so initials label will be visible
//        //else if found then show image
//        UIImage.imageDownloader.download(URLRequest.getRequest(URLS.imageBaseURLString + imageUrlString!)!) { [unowned self] response in
//
//            if let image = response.result.value {
//
//                self.profileImageView.image = image
//                self.nameInitialsLabel.isHidden = true
//                self.profileImageView.isHidden = false
//            }
//            else
//            {
//                self.profileImageView.image = nil
//                self.nameInitialsLabel.isHidden = false
//                self.profileImageView.isHidden = true
//            }
//        }
        
        //set message
        messageLabel.text = conversation.latestReplierMessage
        
        //set time label
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        //convert received string into date and then format it in required format
        let receivedDate = dateFormatter.date(from:conversation.latestReplierDate)
        
        //check if 24 horus has passed to show time differently
        if let diff = Calendar.current.dateComponents([.hour], from: receivedDate!, to: Date()).hour, diff > 24 {
            
            dateFormatter.dateFormat = "dd MMM"
        }
        else
        {
            dateFormatter.dateFormat = "h:mm a"
        }
        
        
        let timeStringToSet = dateFormatter.string(from: receivedDate!)
        self.timeLabel.text = timeStringToSet
        
        
       
        self.roleLabel.text = conversation.latestReplierDesignation
        
        //set read unread background color
        if(conversation.readState == "1"){
            
            self.contentView.backgroundColor = UIColor.clear
        }
        else
        {
            self.contentView.backgroundColor = ColorConstants.kBackgroundColor
        }
    }

}
