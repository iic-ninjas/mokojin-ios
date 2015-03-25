//
//  RatioPresenter.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/25/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation


class RatioPresenter {
    
    
    class func ratioString(match:Match) -> String {
        let chanceA = match.chanceToWin
        let chanceB = 1 - chanceA
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        formatter.maximumFractionDigits = 2
        
        
        if chanceA > chanceB {
            return "\(formatter.stringFromNumber(chanceA/chanceB)!):1"
        } else {
            return "1:\(formatter.stringFromNumber(chanceB/chanceA)!)"
        }
    }

}