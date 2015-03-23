//
//  GoodNightOperaiton.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class GoodNightOperation{
    func run(callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("goodnight", withParameters: buildParams(), block: callback)
    }
    
    func buildParams() -> [NSObject: AnyObject]{
        return [:]
    }
}
