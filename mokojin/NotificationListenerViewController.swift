//
//  NotificationListenerViewController.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class NotificationListenerViewController: UIViewController {
    let notificationManager = NotificationManager()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.listenOnEvents()
    }
    
    private func listenOnEvents(){
        self.notificationManager.registerObserver(self.getNotificationName(), block: { notification in
            self.updateData()
        })
    }
    
    deinit {
        notificationManager.deregisterAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
    }
    
    internal func getNotificationName() -> String {
        fatalError("This method must be overridden")
    }
    
    internal func updateData() {
        fatalError("This method must be overridden")
    }
}