//
//  GetCharacters.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class GetCharacters {
    func get(callback: ([Character])->()){
        PFCloud.callFunctionInBackground("getCharacters", withParameters: nil) { (rawResponse, err) -> Void in
            let characters = rawResponse as [Character]
            callback(characters)
        }
    }
}