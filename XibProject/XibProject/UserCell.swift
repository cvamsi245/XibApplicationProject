//
//  UserCell.swift
//  XibProject
//
//  Created by vamsi on 31/07/24.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        NameLabel.text = nil
    }
    
}
