//
//  TagsTableViewCell.swift
//  NewsTech
//
//  Created by Karizma LTD on 25/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet var tagsCollectionView: UICollectionView!
    
    var tagsTable = [Tag]()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tagsCollectionView.delegate = self
        self.tagsCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TagsTableViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return tagsTable.count
        return tagsTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : TagCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagsCell", for: indexPath) as! TagCollectionViewCell
        cell.tagLabel.text = tagsTable[indexPath.item].name
        return cell
    }
    
}

extension TagsTableViewCell : UICollectionViewDelegate{
    
    
}

extension TagsTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.tagsCollectionView.frame.width/4, height: self.tagsCollectionView.frame.height/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0 , left: 2, bottom: 0 , right: 0.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
