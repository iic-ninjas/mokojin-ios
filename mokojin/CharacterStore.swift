//
//  CharacterStore.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

private let _CharacterStoreInstance = CharacterStore()

class CharacterStore {
    
    class var sharedInstance: CharacterStore {
        return _CharacterStoreInstance
    }
    let NOTIFICATION_NAME = "CharacterStoreUpdated"
    
    let getter = GetCharacters()
    var characters:[Character] = []
    var loaded = false
    
    private init(){
        query()
    }
    
    private func query(){
        loaded = false
        getter.get {
            self.loaded = true
            self.characters = $0
            NSNotificationCenter.defaultCenter().postNotificationName(self.NOTIFICATION_NAME,
                object: self.characters)
        }
        
    }
    
}