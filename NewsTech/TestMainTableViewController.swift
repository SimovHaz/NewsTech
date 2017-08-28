//
//  TestMainTableViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 19/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage
import Parse
import NVActivityIndicatorView


class TestMainTableViewController: UIViewController , IndicatorInfoProvider, NVActivityIndicatorViewable {
    
    @IBOutlet var testTableView: UITableView!
    @IBOutlet weak var loadingView: NVActivityIndicatorView!
    var dataSource: [Post] = [Post]()
    var itemInfo: IndicatorInfo = "View"
    let dateFormatterPrint = DateFormatter()

    
    var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(TestMainTableViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadingScreen()
        
         self.testTableView.refreshControl = refreshControl
      
        self.testTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil ), forCellReuseIdentifier: "cell")
        self.testTableView.backgroundView?.backgroundColor = UIColorFromRGB(rgbValue: 0xeeecf6)
        self.testTableView.rowHeight = UITableViewAutomaticDimension
        self.testTableView.estimatedRowHeight = 288
     
        getAllPosts { (posts, error) in
                if error == nil {
                    self.loadingView.stopAnimating()
                    self.dataSource = posts as! [Post]
                    self.testTableView.reloadData()
                }
                else {
                    print("error get all posts")
                }
            }
        
        //update the nbr of each tag in parse
        getFamousTags { (tags, error) in
            if error == nil {
                for tagT in tags as! [Tag]{
                    getNbrOfTag(tag: tagT) { (posts, error) in
                        if error == nil {
                            tagT.nbrPosts = (posts?.count)!
                            tagT.saveInBackground()
                        }
                    }

                }
            }
        }

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.testTableView.reloadData()
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl){
        self.testTableView.reloadData()
        refreshControl.endRefreshing()
    }
    private func setLoadingScreen() {
        
        loadingView.type = .ballSpinFadeLoader
        loadingView.color = UIColorFromRGB(rgbValue: 0xff0038)
        loadingView.startAnimating()

    }
    
    
}

extension TestMainTableViewController: UITableViewDataSource {
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
        cell.likeNbrLabel.text = String( self.dataSource[indexPath.row].likes.count)
        cell.commentNbrLabel.text = String(self.dataSource[indexPath.row].nbrComment)
        cell.postMainImage.sd_setImage(with: URL(string: self.dataSource[indexPath.row].pictureURL ), placeholderImage: UIImage(named: "Placeholder"), options: SDWebImageOptions()) { (image, error, cacheType, url) in
            if image != nil {
                cell.postMainImage.image = image
            }
        }
        
        if self.dataSource[indexPath.row].videoURL != nil {
            cell.playVideoAvatar.isHidden = false
        }
        //verify loggedIn or Visitor
        if PFUser.current() != nil {
            
            verifyUserCommentOnPost( post: self.dataSource[indexPath.row]) { (response, error) in
                if error == nil{
                    if (response?.count)! > 0{
                        cell.commentPicture.image = UIImage(named: "comment-active")
                    }
                }
            }
            if verifyUserLikes( post: self.dataSource[indexPath.row]) {
                cell.likePostPicture.image = UIImage(named: "like-active")
            }
            
        }
       
        
        
        return cell
    }
}

extension TestMainTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postDetails = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PostDetailsViewController") as! PostDetailsViewController
        postDetails.post = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(postDetails, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
        let height = scrollView.frame.size.height;
        
        let contentYoffset = scrollView.contentOffset.y;
        
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset;
        
        if(distanceFromBottom < height)
        {
            self.testTableView.reloadData()
        }
    }
}
