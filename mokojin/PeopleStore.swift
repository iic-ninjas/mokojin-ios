//
//  PeopleStore.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class PeopleStore {
    func get(){
        PFCloud.callFunctionInBackground("getPeople", withParameters: nil) { (rawResponse, err) -> Void in
//            if let peopleRaw = rawResponse as? [AnyObject] {
//                let people = peopleRaw.map {
//                    let parseObject = $0 as PFObject
//                    return parseObject
//                }
//                println("Hey \(people)")
//            }
            
        }
    }
    
}