//
//  NotificationManager.swift
//  mokojin
//
//  Created by Yonatan Bergman on 4/2/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import Parse

class NotificationManager {
    enum NotificationType: String {
        case SessionDataChanged = "sessionDataChanged"
    }

    func registerForNotifications(application: UIApplication) {
        let userNotificationTypes = (UIUserNotificationType.Alert |
                UIUserNotificationType.Badge |
                UIUserNotificationType.Sound);

        let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
    }

    func updateInstallation(deviceToken:NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock(nil)
    }

    func handleRemoteNotification(userInfo: [NSObject : AnyObject]) {
        if let type = convertRemoteNotificaitonType(userInfo["type"] as? String) {
            switch type {
               case .SessionDataChanged: SessionDataStore.sharedInstance.forceUpdate()
            }
        }
    }

    private func convertRemoteNotificaitonType(type:String?) -> NotificationType? {
        if let typeString = type {
            return NotificationType(rawValue: typeString)
        } else {
            return nil
        }
    }
}