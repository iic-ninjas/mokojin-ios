//
//  SetCharactersOperation.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class SetCharactersOperation{
    func run(player:Player, characterA: TekkenCharacter, characterB: TekkenCharacter?, callback: PFIdResultBlock){
        PFCloud.callFunctionInBackground("setCharacter", withParameters: buildParams(player, characterA, characterB), block: callback)
    }
    
    func buildParams(player:Player, _ characterA: TekkenCharacter, _ characterB: TekkenCharacter?) -> [NSObject: AnyObject]{
        var characterBId:String = ""
        if let cb = characterB {
            characterBId = cb.objectId!
        }
        return [
            "player": player.objectId!,
            "characterA": characterA.objectId!,
            "characterB": characterBId,
        ]
    }
}
