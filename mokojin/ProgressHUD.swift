//
//  ProgressHUD.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

private let _maskType = SVProgressHUDMaskType.Black;

class ProgressHUD{
    
    class func show(){
        show(nil)
    }
    
    class func show(message:String?){
        if let msg = message {
            SVProgressHUD.showWithStatus(msg, maskType: _maskType);
        } else {
            SVProgressHUD.showWithMaskType(_maskType)
        }
    }
    
    class func dismiss(){
        SVProgressHUD.dismiss()
    }
}