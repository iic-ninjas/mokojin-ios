//
//  GetSessionData.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

typealias SessionData = (match: Match?, queue: Queue)
class GetSessionData {
    func get(callback: (SessionData?)->()){
        PFCloud.callFunctionInBackground("getSessionData", withParameters: nil) { (rawResponse, err) -> Void in
            if let dictionary = rawResponse as? [String:AnyObject] {
                if let queue = dictionary["queue"] as? Queue {
                    if let match = dictionary["match"] as? Match {
                        callback((match, queue))
                        return
                    } else {
                        callback((nil, queue))
                        return
                    }                   
                }
            }
            callback(nil)
        }
    }
}