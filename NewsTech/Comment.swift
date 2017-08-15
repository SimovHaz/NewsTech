//
//  Comment.swift
//  NewsTech
//
//  Created by Karizma LTD on 27/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import Foundation
import Parse

class Comment: PFObject, PFSubclassing {
    
    @NSManaged var content: String
    @NSManaged var post: Post
    @NSManaged var user: PFUser
    
    
    //Callbacks
    public typealias SaveResultBlock = (Bool, Error?) -> Void
    public typealias DeleteResultBlock = (Bool, Error?) -> Void
    
    public static func parseClassName() -> String {
        return "Comment"
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: Comment.parseClassName())
        return query
    }
}
