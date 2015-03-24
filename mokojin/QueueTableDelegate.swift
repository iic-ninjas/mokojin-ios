//
//  QueueTableDelegate.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class QueueTableDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {

    let tableView:UITableView
    let notificationManager = NotificationManager()
    var queue:Queue = []
    
    init(tableView: UITableView){
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        updateData()
        notificationManager.registerObserver(SessionDataStoreNotificationName, block: { event in
            self.updateData()
        })
    }
    
    deinit {
        notificationManager.deregisterAll()
    }
    
    func forceUpdate(){
        SessionDataStore.sharedInstance.update()
    }
    
    func updateData(){
        queue = SessionDataStore.sharedInstance.queue
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queue.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QueueItemCellID", forIndexPath: indexPath) as QueueItemCell
        cell.queueItem  = queue[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: false)
    }
    
}