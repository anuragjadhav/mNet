//
//  PeopleTableViewCell.swift
//  mNet
//
//  Created by Anurag Jadhav on 12/28/17.
//  Copyright © 2017 mNet. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var personNameLabel: CustomBrownTextColorLabel!
    @IBOutlet weak var personRoleLabel: CustomBrownTextColorLabel!

    func loadCellWithPeople(_ people:People) {
        
        personNameLabel.text = people.userName
        
        if(people.designation != nil)
        {
            personRoleLabel.text = people.designation
        }
        else
        {
            personRoleLabel.text = "-"
        }
    }
}
