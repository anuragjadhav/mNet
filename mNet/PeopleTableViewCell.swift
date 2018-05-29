//
//  PeopleTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/28/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var personNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var branchNameLabel: CustomBrownTextColorLabel!

    func loadCellWithPeople(_ people:People) {
        
        personNameLabel.text = people.userName
        branchNameLabel.text = people.branchName
        
        let initials = people.userName?.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + ($1 == "" ? "" : "\($1.first!)") }
        initialsLabel.text = initials?.uppercased()

    }
}
