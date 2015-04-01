//
//  CharacterPresenter.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit


private let _emptyPlayerImage:UIImage! = UIImage(named:"player_empty",
                                                inBundle:NSBundle(forClass: CharacterPresenter.self),
                                                compatibleWithTraitCollection:nil)
class CharacterPresenter {
    let character: TekkenCharacter
    
    init(character: TekkenCharacter) {
        self.character = character
    }
    
    func displayName() -> String {
        return self.character.name
    }
    
    func image() -> UIImage {
        return CharacterPresenter.image(self.character)
    }
    
    class func image(character: TekkenCharacter?) -> UIImage{
        if let char = character {
            return UIImage(named: "player_\(char.characterId)",
                inBundle:NSBundle(forClass: CharacterPresenter.self),
                compatibleWithTraitCollection:nil) ?? _emptyPlayerImage
        } else {
            return _emptyPlayerImage
        }
    }
    
    
}