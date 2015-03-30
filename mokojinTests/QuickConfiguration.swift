//
//  QuickConfiguration.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/26/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Quick
import Parse

class ParseTestConfiguration: QuickConfiguration {
    override class func configure(configuration : Configuration) {
        Parse.setApplicationId("GeJyJhvvsIe540zKyn9rCZwSv7AIEcc11DHQjSAV", clientKey: "40quo2Icf83unfXkDu2ZJjEcecPsHl03aqiuNsbH")
        Person.initialize()
        Player.initialize()
        Character.initialize()
        QueueItem.initialize()
        Match.initialize()
    }
}