//
//  PlayerCharactersView.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

private let _highPriority:UILayoutPriority = 750
private let _lowPriority:UILayoutPriority = 250

@IBDesignable
class PlayerCharactersView : UIXibView {
    
    enum Direction{
        case LeftToRight, RightToLeft
        
        func zPositions() -> (left:CGFloat, right:CGFloat){
            switch self {
                case .LeftToRight: return  (left: 1, right: 2)
                case .RightToLeft: return  (left: 2, right: 1)
            }
        }
        
        func isMasking() -> (left:Bool, right:Bool){
            switch self {
            case .LeftToRight: return  (left: false, right: true)
            case .RightToLeft: return  (left: true, right: false)
            }
        }
    }
    
    var player:Player? {
        didSet{
            updatePlayer()
        }
    }
    @IBOutlet weak var stickToLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var characterViewA: AvatarView!
    @IBOutlet weak var characterViewB: AvatarView!

    @IBInspectable
    var borderColor:UIColor = UIColor.clearColor() {
        didSet {
            updateColors()
        }
    }
    
    var direction:Direction = Direction.LeftToRight {
        didSet {
            updateDirection()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setup() {
        updateDirection()
    }
    
    private func updatePlayer(){
        if let player = self.player {
            self.characterViewA.image = CharacterPresenter.image(player.characterA)
            if let character = player.characterB {
                self.characterViewB.hidden = false
                self.characterViewB.image = CharacterPresenter.image(character)
                stickToLeftConstraint.priority = _highPriority
                self.characterViewA.setHasBorder(direction.isMasking().right, animated: false)
                self.characterViewB.setHasBorder(direction.isMasking().left, animated: false)
            } else {
                self.characterViewB.hidden = true
                stickToLeftConstraint.priority = _lowPriority
            }
        }
    }
    
    private func updateColors(){
        self.characterViewA.borderColor = self.borderColor
        self.characterViewB.borderColor = self.borderColor
    }

    private func updateDirection(){
        self.characterViewA.layer.zPosition = direction.zPositions().right
        self.characterViewB.layer.zPosition = direction.zPositions().left
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let player = Player()
        player.characterA = Character(name: "Alex", characterId: 0)
        player.characterB = Character(name: "Moshe", characterId: 2)
        self.player = player
    }

}