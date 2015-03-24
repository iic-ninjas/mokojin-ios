//
//  Character.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class Character : PFObject, PFSubclassing, Hashable {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Character"
    }
    
    @NSManaged var name: String
    @NSManaged var characterId: Int
    
    override var hashValue: Int {
        return self.objectId.hashValue
    }
    
}

func == (this: Character, that: Character) -> Bool {
    return this.objectId == that.objectId
}

func == (this: Character?, that: Character) -> Bool {
    if let unwrappedThis = this {
        return unwrappedThis == that
    } else {
        return false;
    }
}
