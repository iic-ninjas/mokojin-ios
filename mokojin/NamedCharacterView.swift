//
//  CharacterView.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class NamedCharacterView: UIXibView {
    var character:Character = Character() {
        didSet {
            let presenter = CharacterPresenter(character: self.character)
            self.nameView.text = presenter.displayName()
            self.avatarView.image = presenter.image()
        }
    }
    
    var isSelected:Bool = false {
        didSet {
            self.avatarView.hasBorder = self.isSelected
            if self.isSelected {
                self.nameView.textColor = Constants.Colors.lightTextColor
                self.nameView.backgroundColor = Constants.Colors.primaryColor
            } else {
                self.nameView.textColor = Constants.Colors.darkTextColor
                self.nameView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var nameView: UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}