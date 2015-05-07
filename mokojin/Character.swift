//
//  Character.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class TekkenCharacter: PFObject, PFSubclassing {
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    class func parseClassName() -> String! {
        return "Character"
    }
    
    convenience init(name: String, characterId: Int){
        self.init()
        self.name = name
        self.characterId = characterId
    }
    
    @NSManaged var name: String
    @NSManaged var characterId: Int
}
