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
    var borderColor:UIColor = UIColor.clearColor()
    
    @IBInspectable
    var hasBorder:Bool = false {
        didSet {
            if hasBorder {
                self.layer.borderWidth = AvatarView.getBorderWidth(self.layer.frame.width)
                self.layer.borderColor = self.borderColor.CGColor
            } else {
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.clearColor().CGColor
            }
        }
    }
    
    class func getBorderWidth(width:CGFloat) -> CGFloat{
        return ceil(width/22.0)
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