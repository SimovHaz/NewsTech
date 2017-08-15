//
//  LikedPostViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 31/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import  SDWebImage
import Parse


class LikedPostViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataSource: [Post] = [Post]()
    let dateFormatterPrint = DateFormatter()
    
    @IBAction func openMenu(_ sender: Any) {
        slideMenuController()?.toggleRight()
        
    }
    @IBAction func back(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil ), forCellReuseIdentifier: "cell")
        self.tableView.backgroundView?.backgroundColor = UIColorFromRGB(rgbValue: 0xeeecf6)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 288
        if PFUser.current() != nil {
            getLikedPosts{ (posts, error) in
                if error == nil {
                    self.dataSource = posts as! [Post]
                    self.tableView.reloadData()
                }
                else {
                    print("error get liked posts")
                }
            }
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
}
extension LikedPostViewController: UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        dateFormatterPrint.dateFormat = "yyyy.MM.dd"
        
        let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        cell.categoryLabel.text = self.dataSource[indexPath.row].category.name
        cell.categoryLabel.backgroundColor = UIColorFromRGB(rgbValue: UInt(self.dataSource[indexPath.row].category.color, radix: 16)!)
        
        cell.titleLabel.text = self.dataSource[indexPath.row].title
        cell.publishedAtLabel.text =  dateFormatterPrint.string(from: self.dataSource[indexPath.row].createdAt! )
        cell.likeNbrLabel.text = String(self.dataSource[indexPath.row].likes.count)
        cell.commentNbrLabel.text = String(self.dataSource[indexPath.row].nbrComment)
        cell.postMainImage.sd_setImage(with: URL(string: self.dataSource[indexPath.row].pictureURL ), placeholderImage: UIImage(named: "Placeholder"), options: SDWebImageOptions()) { (image, error, cacheType, url) in
            if image != nil {
                cell.postMainImage.image = image
            }
        }
        if self.dataSource[indexPath.row].videoURL != nil {
            cell.playVideoAvatar.isHidden = false
        }
        
        return cell
    }
}

extension LikedPostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetails = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailsViewController") as! PostDetailsViewController
        postDetails.post = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(postDetails, animated: true)
    }
}

