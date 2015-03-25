//
//  person.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

typealias People = [Person]

class Person : PFObject, PFSubclassing, Hashable {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Person"
    }
    
    @NSManaged var name: String
    @NSManaged var rank: Double
    
    override var hashValue: Int {
        return self.objectId.hashValue
    }

}

func == (this: Person, that: Person) -> Bool {
    return this.objectId == that.objectId
}

func == (this: Person?, that: Person) -> Bool {
    if let unwrappedThis = this {
        return unwrappedThis == that
    } else {
        return false;
    }
}
