//
//  AppDelegate.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/22/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import UIKit
import Parse
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationManager = NotificationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("GeJyJhvvsIe540zKyn9rCZwSv7AIEcc11DHQjSAV", clientKey: "40quo2Icf83unfXkDu2ZJjEcecPsHl03aqiuNsbH")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(nil, block: nil)
        initModels()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UITableViewCell.appearance().backgroundColor = UIColor.clearColor()
        Fabric.with([Crashlytics()])
        notificationManager.registerForNotifications(application)
        return true
    }
    
    private func initModels(){
        Person.initialize()
        Player.initialize()
        TekkenCharacter.initialize()
        QueueItem.initialize()
        Match.initialize()
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        notificationManager.updateInstallation(deviceToken)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        notificationManager.handleRemoteNotification(userInfo)
    }

}

