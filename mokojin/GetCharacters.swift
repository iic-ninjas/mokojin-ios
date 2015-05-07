//
//  GetCharacters.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class GetCharacters {
    func get(callback: ([TekkenCharacter])->()){
        PFCloud.callFunctionInBackground("getCharacters", withParameters: nil) { (rawResponse, err) -> Void in
            let characters = rawResponse as! [TekkenCharacter]
            callback(characters)
        }
    }
}