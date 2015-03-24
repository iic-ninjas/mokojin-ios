//
//  CharacterView.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CharacterView: UIView {
    var character:Character = Character() {
        didSet {
            setup()
        }
    }
    
    var isSelected:Bool = false {
        didSet {
            self.avatarView.isSelected = self.isSelected
            if self.isSelected {
                self.nameView.textColor = Constants.sharedInstance.colors.lightTextColor
                self.nameView.backgroundColor = Constants.sharedInstance.colors.primaryColor
            } else {
                self.nameView.textColor = Constants.sharedInstance.colors.darkTextColor
                self.nameView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var nameView: UILabel!
    
    private var loadedXib: Bool = false

    init(character: Character) {
        super.init()
        self.character = character
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        if !self.loadedXib {
            let view = NSBundle.mainBundle().loadNibNamed("CharacterView", owner: self, options: nil)[0] as UIView
            view.frame = self.bounds
            self.addSubview(view)
            self.loadedXib = true
        }
        
        self.nameView.text = self.character.name
        self.avatarView.image = UIImage(named: "player_\(self.character.characterId)")
    }
}