//
//  Match.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class Match : PFObject, PFSubclassing {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Match"
    }
    
    @NSManaged var winner: String?
    @NSManaged var startTime: NSDate
    @NSManaged var expected: Double
    @NSManaged var playerA: Player
    @NSManaged var playerB: Player
    
    var chanceToWin:Double {
        return expected
    }
    
}