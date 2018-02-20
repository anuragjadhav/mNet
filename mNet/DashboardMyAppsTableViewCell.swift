//
//  DashboardMyAppsTableViewCell.swift
//  mNet
//
//  Created by Nachiket Vaidya on 29/12/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class DashboardMyAppsTableViewCell: UITableViewCell {

    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    func setUpCell(app:UserApp) {
        
        titleLabel.text = app.appName
        descriptionLabel.text = app.appDescription
        
        let imageUrlString = app.appLogoLink.components(separatedBy: .whitespaces).joined()
        UIImage.imageDownloader.download(URLRequest.getRequest(URLS.profileImageBaseURLString + imageUrlString)!) { response in
            
            if let image = response.result.value {
                
                self.appImageView.image = image
            }
            else
            {
                self.appImageView.image = nil
            }
        }
    }
    
}
