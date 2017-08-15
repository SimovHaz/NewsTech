//
//  Post.swift
//  NewsTech
//
//  Created by Karizma LTD on 27/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import Foundation
import Parse

class Post: PFObject, PFSubclassing {
    
    @NSManaged var title: String
    @NSManaged var content: String
    @NSManaged var pictureURL: String
    @NSManaged var videoURL: String?
    @NSManaged var tags : [String]?
    @NSManaged var nbrComment: Int
    @NSManaged var likes: [String]
    @NSManaged var note: Int
    @NSManaged var category: Category
   
    public static func parseClassName() -> String {
        return "Post"
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: Post.parseClassName())
        return query
    }
    


}
