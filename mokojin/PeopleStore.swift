//
//  PeopleStore.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

private let _PeopleStoreInstance = PeopleStore()

class PeopleStore {
    
    class var sharedInstance: PeopleStore {
        return _PeopleStoreInstance
    }
    let NOTIFICATION_NAME = "PeopleStoreUpdated"
    
    let getter = GetPeople()
    var people:People = []
    var loaded = false
    
    private init(){
        query()
    }
    
    private func query(){
        loaded = false
        getter.get {
            self.loaded = true
            self.people = $0
            NSNotificationCenter.defaultCenter().postNotificationName(self.NOTIFICATION_NAME,
                object: self.people)
        }
    
    }
    
}