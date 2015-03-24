//
//  CharacterCellView.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class CharacterCellView: UICollectionViewCell {

    @IBOutlet weak var characterView: NamedCharacterView!
    
    func performSelectionAnimations(){
        self.characterView.isSelected = self.selected
    }
}