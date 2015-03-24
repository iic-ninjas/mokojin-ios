//
//  QueuePresenter.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
class QueuePresenter {
    class func timeago(date:NSDate) -> String {
        let interval = date.timeIntervalSinceNow * -1
        let minutes = Int(interval / 60)
        let seconds = Int(interval % 60)
        return String(format: "%d:%02d", arguments: [minutes, seconds])
    }
}