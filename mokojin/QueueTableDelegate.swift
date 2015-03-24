//
//  QueueTableDelegate.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class QueueTableDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {

    let notificationManager = NotificationManager()
    var queue:Queue = []
    
    override init(){
        super.init()
        notificationManager.registerObserver(SessionDataStoreNotificationName, block: { event in
            self.updateData()
        })
    }
    
    deinit {
        notificationManager.deregisterAll()
    }
    
    func updateData(){
        queue = SessionDataStore.sharedInstance.queue
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queue.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QueueItemCellID") as UITableViewCell
        cell.textLabel?.text = queue[indexPath.row].player.person.name
        return cell
    }

}