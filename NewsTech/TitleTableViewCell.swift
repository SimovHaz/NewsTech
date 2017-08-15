//
//  TitleTableViewCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 25/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import Parse

class TitleTableViewCell: UITableViewCell {
    var userLikePost : Bool!
    @IBOutlet var likeBtnImage: UIButton!
    @IBOutlet var publishedAt: UILabel!
    @IBOutlet var likesNbre: UILabel!
    @IBOutlet var commentNbre: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commentNbre.font = UIFont(name: "JannaLT-Regular", size: 15)
        self.publishedAt.font = UIFont(name: "JannaLT-Regular", size: 15)
        self.titleLabel.font = UIFont(name: "JannaLT-Regular", size: 15)
        self.likesNbre.font = UIFont(name: "JannaLT-Regular", size: 15)
    }
    
 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
