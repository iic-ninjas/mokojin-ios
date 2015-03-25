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
            self.avatarView.setHasBorder(self.isSelected, animated: true) 
            if self.isSelected {
                self.nameView.textColor = Constants.Colors.lightTextColor
                self.nameView.backgroundColor = Constants.Colors.primaryColor
                animateNameView()
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
    
    func animateNameView(){
        let animation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        animation.toValue = NSValue(CGPoint: CGPointMake(0.8, 0.8))
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        self.nameView.pop_addAnimation(animation, forKey: "spring")
    }

}