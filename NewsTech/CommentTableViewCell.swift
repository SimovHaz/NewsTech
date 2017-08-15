//
//  CommentTableViewCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 25/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import Parse
import Toast_Swift
class CommentTableViewCell: UITableViewCell {

    @IBOutlet var commentTextView: UITextField!
    
    @IBOutlet var sendComment: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commentTextView.font = UIFont(name: "JannaLT-Regular", size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
