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
class PlayerCharactersView : UIXibView {

    @IBOutlet weak var stickToLeftConstraint: NSLayoutConstraint!
    
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
            if let p = player {
                self.characterViewA.image = CharacterPresenter.image(p.characterA)
                if let character = p.characterB {
                    self.characterViewB.hidden = false
                    self.characterViewB.image = CharacterPresenter.image(character)
                    stickToLeftConstraint.priority = _highPriority
                    self.characterViewA.hasBorder = direction.isMasking().right
                    self.characterViewB.hasBorder = direction.isMasking().left
                } else {
                    self.characterViewB.hidden = true
                    stickToLeftConstraint.priority = _lowPriority
                }
            }
            
        }
    }
    @IBOutlet weak var characterViewA: AvatarView!
    @IBOutlet weak var characterViewB: AvatarView!

    @IBInspectable
    var borderColor:UIColor = UIColor.clearColor() {
        didSet {
            self.characterViewA.borderColor = self.borderColor
            self.characterViewB.borderColor = self.borderColor
        }
    }
    
    @IBInspectable
    var direction:Direction = Direction.LeftToRight {
        didSet {
            updateDirection()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        updateDirection()
    }

    func updateDirection(){
        self.characterViewA.layer.zPosition = direction.zPositions().right
        self.characterViewB.layer.zPosition = direction.zPositions().left
    }

}