//
//  PostTableViewCell.swift
//  
//
//  Created by Karizma LTD on 19/07/2017.
//
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet var shareButton: UIButton!
    @IBOutlet var viewCell: UIView!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var likeNbrLabel: UILabel!
    @IBOutlet var likePostPicture: UIImageView!
    @IBOutlet var commentNbrLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    
    @IBOutlet var commentPicture: UIImageView!
    @IBAction func shareAction(_ sender: Any) {
    }
    @IBOutlet var postMainImage: UIImageView!
    @IBOutlet var playVideoAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shareButton.layer.borderColor = UIColorFromRGB(rgbValue: 0x0d5be9).cgColor
        self.shareButton.layer.borderWidth = 1
        self.shareButton.layer.cornerRadius = self.shareButton.frame.height/2
        self.shareButton.layer.masksToBounds = true
        self.viewCell.layer.borderColor = UIColor.lightGray.cgColor
        self.viewCell.layer.borderWidth = 0.5
        self.viewCell.layer.masksToBounds = true

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.playVideoAvatar.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
