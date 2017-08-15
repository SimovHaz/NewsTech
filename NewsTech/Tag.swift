//
//  Tag.swift
//  NewsTech
//
//  Created by Karizma LTD on 27/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import Foundation
import Parse

class Tag: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var nbrPosts: Int
  
    
    public static func parseClassName() -> String {
        return "Tag"
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: Tag.parseClassName())
        return query
    }
    

}
