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

let CharacterStoreNotificationName = "CharacterStoreUpdated"
class CharacterStore {
    
    class var sharedInstance: CharacterStore {
        return _CharacterStoreInstance
    }

    let getter = GetCharacters()
    var characters:[TekkenCharacter] = []
    var loaded = false
    
    private init(){
        query()
    }
    
    func forceUpdate() -> CharacterStore {
        query()
        return self
    }
    
    private func query(){
        loaded = false
        getter.get {
            self.loaded = true
            self.characters = $0
            NSNotificationCenter.defaultCenter().postNotificationName(CharacterStoreNotificationName,
                object: self.characters)
        }
        
    }
    
}