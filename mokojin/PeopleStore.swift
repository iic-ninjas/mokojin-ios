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

let PeopleStoreNotificationName = "PeopleStoreUpdated"
class PeopleStore {
    
    class var sharedInstance: PeopleStore {
        return _PeopleStoreInstance
    }

    let getter:GetPeople
    var people:People = []
    var loaded = false
    
    internal init(getter:GetPeople = GetPeople()){
        self.getter = getter
        query()
    }
    
    func forceUpdate() -> PeopleStore {
        query()
        return self
    }
    
    private func query(){
        loaded = false
        getter.get {
            self.loaded = true
            self.people = $0
            NSNotificationCenter.defaultCenter().postNotificationName(PeopleStoreNotificationName,
                object: self.people)
        }
    
    }
    
}