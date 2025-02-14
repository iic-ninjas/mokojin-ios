//
//  Player.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class Player : PFObject, PFSubclassing {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Player"
    }
    
    @NSManaged var person: Person
    @NSManaged var characterA: TekkenCharacter?
    @NSManaged var characterB: TekkenCharacter?
    
}