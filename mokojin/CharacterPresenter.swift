//
//  CharacterPresenter.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class CharacterPresenter {
    let character:Character
    
    init(character: Character) {
        self.character = character
    }
    
    func displayName() -> String {
        return self.character.name
    }
    
    func image() -> UIImage {
        return UIImage(named: "player_\(self.character.characterId)")!
    }
}