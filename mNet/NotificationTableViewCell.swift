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
    @IBOutlet weak var nameInitialsLabel: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
    
    func loadCellWith(_ notification:NotificationObject)
    {
        messageLabel.text = notification.notificationMessage
        dateTimeLabel.text = notification.createdOn
        
        self.profileImageView.isHidden = true
        
        //set name initials and name label
        let initials = notification.username?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + ($1 == "" ? "" : "\($1.first!)") }
        nameInitialsLabel.text = initials?.uppercased()
        
//        //removed extra spaces in string
//        var imageUrlString = notification.profileImgLink?.components(separatedBy: .whitespaces).joined()
//
//        if(imageUrlString == nil)
//        {
//            imageUrlString = ""
//        }
//
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
