//
//  TagCollectionViewCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 25/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tagLabel: UILabel!
    override func awakeFromNib() {
        tagLabel.font = UIFont(name: "JannaLT-Regular", size: 17)
        self.layer.cornerRadius = self.tagLabel.frame.height/4
        self.layer.masksToBounds = true
    }
}
