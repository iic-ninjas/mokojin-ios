//
//  UIXibView.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class UIXibView : UIView {
    
    private var loadedXib: Bool = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    func setup(){
    }
    
    private func loadXib() {
        if !self.loadedXib {
            let _customView = NSBundle.mainBundle().loadNibNamed(className(), owner: self, options: nil).first as UIView
            if CGRectIsEmpty(frame){
                self.bounds = _customView.bounds
            } else {
                _customView.frame = self.bounds
                _customView.setTranslatesAutoresizingMaskIntoConstraints(false)
            }

            self.addSubview(_customView)
            let views = ["customView": _customView]
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[customView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[customView]|", options: NSLayoutFormatOptions.allZeros, metrics: nil, views: views))
            self.loadedXib = true
        }
        setup()
    }
    
    private func className() -> String {
        let fullClassName = NSStringFromClass(self.dynamicType) //Tekken_Time.NamedCharacterView
        return split(fullClassName) {$0 == "."}.last!
    }
}