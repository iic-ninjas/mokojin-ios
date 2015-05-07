//
//  PFObject+Equality.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/25/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

extension PFObject: Hashable, Equatable {
    
    public override var hashValue: Int {
        return self.objectId!.hashValue
    }
    
}

public func ==(lhs: PFObject, rhs: PFObject) -> Bool {
    return lhs.objectId == rhs.objectId
}
