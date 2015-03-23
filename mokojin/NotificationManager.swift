//
//  NotificationManager.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class NotificationManager {
    private var observerTokens: [AnyObject] = []
    
    deinit {
        deregisterAll()
    }
    
    func deregisterAll() {
        for token in observerTokens {
            NSNotificationCenter.defaultCenter().removeObserver(token)
        }
        
        observerTokens = []
    }
    
    func registerObserver(name: String!, block: (NSNotification! -> Void)) {
        let newToken = NSNotificationCenter.defaultCenter().addObserverForName(name, object: nil, queue: nil) {note in
            block(note)
        }
        
        observerTokens.append(newToken)
    }
    
    func registerObserver(name: String!, forObject object: AnyObject!, block: (NSNotification! -> Void)) {
        let newToken = NSNotificationCenter.defaultCenter().addObserverForName(name, object: object, queue: nil) {note in
            block(note)
        }
        
        observerTokens.append(newToken)
    }
    
}