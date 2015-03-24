//
//  AvatarView.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AvatarView: UIImageView {
    
    @IBInspectable
    var isMasking:Bool = false {
        didSet {
            if self.isMasking {
                self.layer.borderWidth = 2
                self.layer.borderColor = Constants.Colors.lightBackgroundColor.CGColor
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    
    @IBInspectable
    var isSelected:Bool = false {
        didSet {
            if self.isSelected {
                self.layer.borderWidth = 5
                self.layer.borderColor = Constants.Colors.primaryColor.CGColor
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override init(image: UIImage!) {
        super.init(image: image)
        setup()
    }
    
    override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.layer.frame.width / 2;
    }
    
    private func setup() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}