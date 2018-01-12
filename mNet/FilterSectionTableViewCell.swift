//
//  FilterSectionTableViewCell.swift
//  mNet
//
//  Created by Nachiket Vaidya on 12/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class FilterSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var filterNameLabel: CustomBlueTextColorLabel!
    @IBOutlet weak var selectionView: UIView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionView.layer.shadowColor = UIColor.black.cgColor
        selectionView.layer.shadowOffset = CGSize(width: 0, height: 0)
        selectionView.layer.shadowOpacity = 0.5
        selectionView.layer.shadowRadius = 4.0
        selectionView.layer.masksToBounds = false
    }
}
