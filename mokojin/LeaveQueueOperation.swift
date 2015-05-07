//
//  LeaveQueueOperation.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class LeaveQueueOperation{
    func run(queueItem: QueueItem, callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("leaveQueue", withParameters: buildParams(queueItem), block: callback)
    }
    
    func buildParams(queueItem: QueueItem) -> [NSObject: AnyObject]{
        return [
            "queueItem": queueItem.objectId!
        ]
    }
}
