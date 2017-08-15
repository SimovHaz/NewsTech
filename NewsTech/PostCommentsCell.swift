//
//  PostCommentsCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 26/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit

class PostCommentsCell: UITableViewCell {

    @IBOutlet var deleteComment: UIButton!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.commentLabel.font = UIFont(name: "JannaLT-Regular", size: 20)
        self.userName.font = UIFont(name: "JannaLT-Regular", size: 20)
        
        self.userPic.layer.cornerRadius = self.userPic.frame.height/2
        self.userPic.layer.masksToBounds = true
        
        self.commentLabel.layer.cornerRadius = self.frame.height/6
        self.commentLabel.layer.borderColor = UIColorFromRGB(rgbValue: 0xb9cbea).cgColor
        self.commentLabel.layer.borderWidth = 2
        self.commentLabel.layer.masksToBounds = true
        


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
