//
//  EndMatchOperation.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

enum WinnerEnum: String{
    case PlayerA = "playerA",
         PlayerB = "playerB"
}

class EndMatchOperation{
    func run(match: Match, winner: WinnerEnum, callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("endMatch", withParameters: buildParams(match, winner), block: callback)
    }
    
    func buildParams(match: Match, _ winner: WinnerEnum) -> [NSObject: AnyObject]{
        return [
            "match": match.objectId!,
            "winner": winner.rawValue
        ]
    }
}
