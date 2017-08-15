//
//  Category.swift
//  NewsTech
//
//  Created by Karizma LTD on 27/07/2017.
//  Copyright © 2017 Karizma LTD. All rights reserved.
//

import Foundation
import Parse

class Category: PFObject, PFSubclassing {
    
    @NSManaged var name: String
    @NSManaged var picture: String
    @NSManaged var nbrPost: Int
    @NSManaged var color: String

    
    
    public static func parseClassName() -> String {
        return "Category"
    }
    
    override class func query() -> PFQuery<PFObject>? {
        let query = PFQuery(className: Category.parseClassName())
        return query
    }
    
 

}
