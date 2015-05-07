//
//  CreatePersonOperation.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class CreatePersonOperation{
    func run(name: String, callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("createPerson", withParameters: buildParams(name), block: callback)
    }
    
    func buildParams(name: String) -> [NSObject: AnyObject]{
        return [
            "name": name
        ]
    }
}
