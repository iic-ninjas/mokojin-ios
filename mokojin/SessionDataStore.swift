//
//  SessionDataStore.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

private let _SessionDataStoreInstance = SessionDataStore()

let SessionDataStoreNotificationName = "SessionDataStoreUpdated"
class SessionDataStore {
    
    class var sharedInstance: SessionDataStore {
        return _SessionDataStoreInstance
    }

    let getter = GetSessionData()

    var match:Match? = nil
    var queue:Queue = []
    var loaded = false
    
    private init(){
        query()
    }
    
    func update() -> SessionDataStore {
        query()
        return self
    }
    
    private func query(){
        loaded = false
        getter.get {
            self.loaded = true
            if let sessionData = $0 {
                self.match = sessionData.match
                self.queue = sessionData.queue
            }
            NSNotificationCenter.defaultCenter().postNotificationName(SessionDataStoreNotificationName, object: nil)
        }
        
    }
    
    func currentPlayingPeople() -> People {
        var people:People = queue.map { (queueItem:QueueItem) in
            queueItem.player.person
        }
        if let currentMatch = self.match {
            people.append(currentMatch.playerA.person)
            people.append(currentMatch.playerB.person)
        }
        return people
    }
}