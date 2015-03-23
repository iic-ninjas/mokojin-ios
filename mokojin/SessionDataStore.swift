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

class SessionDataStore {
    
    class var sharedInstance: SessionDataStore {
        return _SessionDataStoreInstance
    }
    let NOTIFICATION_NAME = "SessionDataStoreUpdated"
    
    let getter = GetSessionData()

    var match:Match? = nil
    var queue:Queue = []
    var loaded = false
    
    private init(){
        query()
    }
    
    private func query(){
        loaded = false
        getter.get {
            self.loaded = true
            if let sessionData = $0 {
                self.match = sessionData.match
                self.queue = sessionData.queue
                NSNotificationCenter.defaultCenter().postNotificationName(self.NOTIFICATION_NAME, object: nil)
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(self.NOTIFICATION_NAME, object: nil)
            }
        }
        
    }
    
}