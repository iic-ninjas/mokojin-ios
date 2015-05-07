//
//  CharacterView.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class NamedCharacterView: UIXibView {
    
    var character: TekkenCharacter! {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    var isSelected:Bool = false {
        didSet {
            self.avatarView.setHasBorder(self.isSelected, animated: true)
            animateNameView()
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
    
    func animateNameView(){
        let animation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        animation.fromValue = NSValue(CGPoint: CGPointMake(1, 1))
        animation.toValue = NSValue(CGPoint: CGPointMake(0.8, 0.8))
        animation.duration = 0.2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.autoreverses = true
        self.nameView.pop_addAnimation(animation, forKey: "spring")
    }
    
    private func updateUI(){
        let presenter = CharacterPresenter(character: self.character)
        self.nameView.text = presenter.displayName()
        self.avatarView.image = presenter.image()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.character = TekkenCharacter(name: "Alex", characterId: 0)
    }

}