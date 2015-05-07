//
//  JoinQueueOperation.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class JoinQueueOperation{
    func run(person:Person, callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("joinQueue", withParameters: buildParams(person), block: callback)
    }
    
    func buildParams(person:Person) -> [NSObject: AnyObject]{
        return ["person": person.objectId!]
    }
}
