//
//  SetCharactersOperation.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class SetCharactersOperation{
    func run(player:Player, characterA:Character, characterB:Character?, callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("setCharacter", withParameters: buildParams(player, characterA, characterB), block: callback)
    }
    
    func buildParams(player:Player, _ characterA:Character, _ characterB:Character?) -> [NSObject: AnyObject]{
        var characterBId:String = ""
        if let cb = characterB {
            characterBId = cb.objectId
        }
        return [
            "player": player.objectId,
            "characterA": characterA.objectId,
            "characterB": characterBId,
        ]
    }
}
