//
//  GetPeople.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class GetPeople {
    func get(callback: (People)->()){
        PFCloud.callFunctionInBackground("getPeople", withParameters: nil) { (rawResponse, err) -> Void in
            if let people = rawResponse as? People {
                callback(people)
            }
        }
    }

}