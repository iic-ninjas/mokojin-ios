//
//  Constants.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

private let _constantsInstance = Constants()

class Constants {
    
    let colors = Colors()
    
    class var sharedInstance: Constants {
        return _constantsInstance
    }
    
    class Colors {
        let primaryColor:UIColor = UIColor(red:0.917, green:0.258, blue:0.176, alpha:1)
        let darkTextColor:UIColor = UIColor(red:0, green:0, blue:0, alpha:1)
        let lightTextColor:UIColor = UIColor(red:1, green:1, blue:1, alpha:1)
    }
}