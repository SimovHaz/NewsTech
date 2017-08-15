//
//  FamousTagsTableViewCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 31/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit

class FamousTagsTableViewCell: UITableViewCell {

    @IBOutlet var hashtagNbrLabel: UILabel!
    @IBOutlet var hashtagNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
