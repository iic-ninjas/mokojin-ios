//
//  CharacterView.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class CharacterView: UIView {
    var character:Character = Character() {
        didSet {
            setup()
        }
    }
    
    var avatarView: AvatarView?
    var nameView: UITextView?
    
    init(character: Character) {
        super.init()
        self.character = character
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        if self.nameView != nil { self.nameView!.removeFromSuperview() }
        if self.avatarView != nil { self.avatarView!.removeFromSuperview() }
        
        self.nameView = UITextView()
        self.nameView!.text = self.character.name
        self.addSubview(self.nameView!)
        
        self.avatarView = AvatarView(image: UIImage(named: "player_\(self.character.characterId)"))
        self.addSubview(self.avatarView!)
    }
}