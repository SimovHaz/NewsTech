//
//  PostDetailsViewController.swift
//  NewsTech
//
//  Created by Karizma LTD on 21/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SDWebImage
import Parse
import Toast_Swift
import Lightbox
import AVFoundation


class PostDetailsViewController: UIViewController {
    
    var post : Post!
    var postComments = [Comment]()
    var style = ToastStyle()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var playVideo: UIButton!
    @IBAction func showVideo(_ sender: Any) {
        
        let images = [
           
            LightboxImage(
                image: thumbnailForVideoAtURL(url: URL(string: post.videoURL!)!)!,
                text: "",
                videoURL: URL(string: post.videoURL!)
            )
        ]
        
        let controller = LightboxController(images: images)
        controller.dynamicBackground = true
        
        present(controller, animated: true, completion: nil)
    }
    
    private func thumbnailForVideoAtURL(url: URL) -> UIImage? {
        
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("error")
            return nil
        }
    }
  

    @IBOutlet var MainPostPic: UIImageView!
    let dateFormatterPrint = DateFormatter()
    
    
    @IBOutlet var topHeaderView: NSLayoutConstraint!
    @IBOutlet var headerViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //post Image
        MainPostPic.sd_setImage(with: URL(string: post.pictureURL ), placeholderImage: UIImage(named: "Placeholder"), options: SDWebImageOptions()) { (image, error, cacheType, url) in
            if image != nil {
                self.MainPostPic.image = image
            }
        }
        if self.post.videoURL != nil {
            self.playVideo.isHidden = false
        }
        
        //get comments of post
            getCommentsInPost(post: post, completionBlock: { (comments, error) in
                if error == nil {
                    self.postComments = comments as! [Comment]
                    self.tableView.reloadData()
                }
            })
       
        
    }
    
    
    @IBAction func back(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /* func x( _ gr: UITapGestureRecognizer) {
     let location = gr.location(in: self.tableView)
     if let indexPath = tableView.indexPathForRow(at: location) {
     if let cell = self.tableView.cellForRow(at: indexPath) {
     
     }
     }
     }*/
    func addCommentAction(_ sender: UIButton) {
        if PFUser.current() != nil {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? CommentTableViewCell
            {
                cell.setLoadingScreen()
                if !(cell.commentTextView.text?.isEmpty)!{
                    let comment = Comment()
                    comment.content = cell.commentTextView.text!
                    comment.user = PFUser.current()!
                    comment.post = self.post
                    
                    addCommentsInPost(comment: comment, completionBlock: { (success, error) in
                        if error == nil {
                            if success! {
                                updatePostAfterComment(post: self.post, completionBlock: { (success, error) in
                                    if error == nil {
                                        if success! {
                                            getCommentsInPost(post: self.post, completionBlock: { (comments, error) in
                                                if error == nil {
                                                    cell.loadingView.stopAnimating()
                                                    cell.loadingView.isHidden = true
                                                    cell.sendComment.isHidden = false
                                                    cell.commentTextView.text?.removeAll()
                                                    self.postComments = comments as! [Comment]
                                                    self.tableView.reloadData()
                                                    
                                                }
                                            })
                                            
                                            
                                        }
                                    }
                                })
                            }
                            
                        }
                    })
                }
            }
            
        } else {
            self.style.backgroundColor = UIColorFromRGB(rgbValue: 0xcfced5)
            self.style.messageColor = UIColorFromRGB(rgbValue: 0xff0038)
            self.view.makeToast("يجب عليك تسجيل الدخول أولا", duration: 2, position: .bottom, title: "click to register", image: nil, style: self.style, completion: { (didTap) in
                if didTap {
                    let currentView : UIViewController = UIStoryboard.init(name: "main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")
                    self.present(currentView, animated: true, completion: nil)
                }
            })
        }
        
    }
    
    func deleteCommentAction(_ sender: UIButton) {
            let indexPath = IndexPath(row: sender.tag, section: 0)
            if (tableView.cellForRow(at: indexPath) as? PostCommentsCell) != nil
            {
                
                deleteUserComment(comment: postComments[indexPath.row - 4], completionBlock: { (success, error) in
                    if error == nil {
                        updatePostAfterDeleteComment(post: self.post, completionBlock: { (success, error) in
                            if error == nil {
                                getCommentsInPost(post: self.post, completionBlock: { (comments, error) in
                                    if error == nil {
                                        self.postComments = comments as! [Comment]
                                        self.tableView.reloadData()
                                        
                                    }
                                })
                            }
                        })
                        
                    }
                })
                
            }
        
        
    }
    
    func addRemoveLike(_ sender: UIButton) {
        if PFUser.current() != nil {
            
            if post.likes.contains(PFUser.current()!.objectId!) {
                removeLikeFromPost(post: self.post, completionBlock: { (success, error) in
                    if success{
                        sender.setImage(UIImage(named: "like"), for: UIControlState.normal)
                        self.tableView.reloadData()
                    }
                })
            }
            else{
                addLikeToPost(post: self.post, completionBlock: { (success, error) in
                    if success{
                        sender.setImage(UIImage(named: "like-active"), for: UIControlState.normal)
                        self.tableView.reloadData()
                    }
                })
            }
        } else {
            self.style.backgroundColor = UIColorFromRGB(rgbValue: 0xcfced5)
            self.style.messageColor = UIColorFromRGB(rgbValue: 0xff0038)
            self.view.makeToast("يجب عليك تسجيل الدخول أولا", duration: 2, position: .bottom, title: "click to register", image: nil, style: self.style, completion: { (didTap) in
                if didTap {
                    let currentView : UIViewController = UIStoryboard.init(name: "main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController")
                    self.present(currentView, animated: true, completion: nil)
                }
            })
        }
    }
    
   
}

extension PostDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 + postComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            dateFormatterPrint.dateFormat = "yyyy.MM.dd"
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? TitleTableViewCell
            cell?.commentNbre.text = String(post.nbrComment)
            cell?.likesNbre.text = String(post.likes.count)
            cell?.publishedAt.text = dateFormatterPrint.string(from: self.post.createdAt! )
            cell?.titleLabel.text = post.title
            
            if PFUser.current() != nil {
                if post.likes.contains(PFUser.current()!.objectId!) {
                    cell?.likeBtnImage.setImage(UIImage(named: "like-active"), for: UIControlState.normal)
                    cell?.userLikePost = true
                }
            }
            
            cell?.likeBtnImage.addTarget(self, action: #selector(self.addRemoveLike(_:)), for: .touchUpInside)
            
            return cell!
            
            //content row
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as? DescriptionTableViewCell
            cell?.descriptionLabel.text = post.content
            return cell!
            
            //tags row
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell", for: indexPath) as? TagsTableViewCell
            if self.post.tags != nil {
                getTagsTable(post: self.post, completionBlock: { (tags, error) in
                    if error == nil {
                        cell?.tagsTable = tags as! [Tag]
                        cell?.tagsCollectionView.reloadData()
                    }
                })
            }
            return cell!
            
            //add comment row
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentTableViewCell
            cell?.sendComment.tag = indexPath.row
            cell?.sendComment.addTarget(self, action: #selector(self.addCommentAction(_:)), for: .touchUpInside)
            
            return cell!
            
            //showing all comments of the post
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "postCommentCell", for: indexPath) as? PostCommentsCell
            if cell == nil {
                tableView.register(UINib(nibName: "PostCommentsCell", bundle: nil), forCellReuseIdentifier: "postCommentCell")
                cell = tableView.dequeueReusableCell(withIdentifier: "postCommentCell", for: indexPath) as? PostCommentsCell
            }
            if let avatar = postComments[indexPath.row - 4].user["avatar"] as? String {
                cell?.userPic.sd_setImage(with: URL(string: avatar ), placeholderImage: UIImage(named: "Placeholder"), options: SDWebImageOptions()) { (image, error, cacheType, url) in
                    if image != nil {
                        cell?.userPic.image = image
                    }
                }
            }
            if PFUser.current() != nil && PFUser.current()?.username == postComments[indexPath.row - 4].user.username {
                cell?.deleteComment.isHidden = false
            }
            cell?.deleteComment.tag = indexPath.row
            cell?.deleteComment.addTarget(self, action: #selector(self.deleteCommentAction(_:)), for: .touchUpInside)
            cell?.commentLabel.text = postComments[indexPath.row - 4].content
            cell?.userName.text = postComments[indexPath.row - 4].user["username"] as? String
            return cell!
        }
    }
    
}

extension PostDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //parallax
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            self.topHeaderView.constant = offsetY
            self.headerViewHeight.constant = 270 - offsetY
        }
    }
}
