//
//  CategoryTableViewCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 26/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet var categoryName: UILabel!
    @IBOutlet var categoryPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         self.categoryName.font = UIFont(name: "JannaLT-Regular", size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
