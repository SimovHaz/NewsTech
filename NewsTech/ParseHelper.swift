//
//  ParseHelper.swift
//  NewsTech
//
//  Created by Karizma LTD on 27/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import Foundation
import Parse

func getAllPosts(completionBlock: @escaping ([PFObject]?,Error?) -> Void) {    
    let query = Post.query()
    query?.order(byDescending: "createdAt")
    query?.includeKey("category")
    query?.findObjectsInBackground(block: completionBlock)
}

func getFamousPosts(completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    let query = Post.query()
    query?.order(byDescending: "note")
    // Include the category with each Post
    query?.includeKey("category")
    query?.findObjectsInBackground(block: completionBlock)
}

func getLikedPosts(completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    let query = Post.query()
    query?.order(byDescending: "note")
    query?.whereKey("likes", contains: PFUser.current()?.objectId)
    // Include the category with each Post
    query?.includeKey("category")
    query?.findObjectsInBackground(block: completionBlock)
}

func getPostsByTag(tag:Tag ,completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    let query = Post.query()
    query?.order(byDescending: "note")
    // Include the category with each Post
    query?.includeKey("category")
    query?.whereKey("tags", equalTo: tag.objectId!)
    query?.findObjectsInBackground(block: completionBlock)
}

func getPostsByCategory(category : Category ,completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    let query = Post.query()
    query?.order(byDescending: "note")
    // Include the category with each Post
    query?.includeKey("category")
    query?.whereKey("category", equalTo: category)
    query?.findObjectsInBackground(block: completionBlock)
}


//comment
func getCommentsInPost(post: Post ,completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    let query = Comment.query()
    query?.order(byDescending: "createdAt")
    query?.whereKey("post", equalTo: post)
    // Include the user data with each comment
    query?.includeKey("user")
    query?.findObjectsInBackground(block: completionBlock)
}
func getNumberCommentsInPost(post: Post ,completionBlock: @escaping ([PFObject]?,Error?) -> Void){
    
}

func addCommentsInPost(comment : Comment,completionBlock: @escaping (Bool?,Error?) -> Void){
    comment.saveInBackground(block: completionBlock)
}

func deleteUserComment(comment : Comment, completionBlock: @escaping (Bool?,Error?) -> Void) {
    comment.deleteInBackground()
    comment.saveInBackground(block: completionBlock)
}
func updatePostAfterDeleteComment(post: Post ,completionBlock: @escaping (Bool?,Error?) -> Void){
    post.nbrComment = post.nbrComment - 1
    post.note = post.note - 1
    post.saveInBackground(block: completionBlock)
}
func updatePostAfterComment(post: Post ,completionBlock: @escaping (Bool?,Error?) -> Void){
    post.nbrComment = post.nbrComment + 1
    post.note = post.note + 1
    post.saveInBackground(block: completionBlock)
}


// category
func getCategories(completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    let query = Category.query()
    query?.order(byDescending: "createdAt")
    query?.findObjectsInBackground(block: completionBlock)
}

//tag

func getFamousTags(completionBlock: @escaping ([PFObject]?,Error?) -> Void) {
    
    let query = Tag.query()
    query?.order(byDescending: "nbrPosts")
    query?.findObjectsInBackground(block: completionBlock)
}

func getTagsTable(post : Post , completionBlock: @escaping ([PFObject]?,Error?)-> Void ) {
    let query = Tag.query()
    query?.whereKey("objectId", containedIn: post.tags!)
    query?.findObjectsInBackground(block: completionBlock)
    
}

func getNbrOfTag(tag : Tag , completionBlock: @escaping ([PFObject]?,Error?)-> Void ) {
    let query = Post.query()
    query?.whereKey("tags", contains: tag.objectId)
    query?.findObjectsInBackground(block: completionBlock)
}

func updateNbrOfTag(tag : Tag , completionBlock: @escaping ([PFObject]?,Error?)-> Void ) {
    let query = Post.query()
    query?.whereKey("tags", contains: tag.objectId)
    query?.findObjectsInBackground(block: completionBlock)
}

//user
func addLikeToPost(post : Post ,completionBlock: @escaping (Bool, Error?) -> Void){
    post.add((PFUser.current()?.objectId)!, forKey: "likes")
    post.note =  post.note + 1
    post.saveInBackground(block: completionBlock)
}

func removeLikeFromPost(post : Post ,completionBlock: @escaping (Bool, Error?) -> Void){
    post.remove((PFUser.current()?.objectId)!, forKey: "likes")
    post.note =  post.note - 1

    post.saveInBackground(block: completionBlock)
}

func verifyUserLikes(post : Post )-> Bool {
    if post.likes.contains(PFUser.current()!.objectId!) {
        return true
    }
    return false
}

func verifyUserCommentOnPost(post : Post , completionBlock: @escaping ([PFObject]?,Error?)-> Void){
    let query = Comment.query()
    query?.whereKey("post", equalTo: post)
    query?.whereKey("user", equalTo: PFUser.current()!)
    query?.findObjectsInBackground(block: completionBlock)
}

