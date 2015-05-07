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
    var dontRefresh = false
    
    init(tableView: UITableView){
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        updateData()
        notificationManager.registerObserver(SessionDataStoreNotificationName, block: { event in
            self.updateData()
        })
        NSTimer.scheduledTimerWithTimeInterval(1.0, block: {
            if !self.dontRefresh {
                self.updateData()
            }
            }, repeats: true)
    }
    
    deinit {
        notificationManager.deregisterAll()
    }
    
    func forceUpdate(){
        SessionDataStore.sharedInstance.forceUpdate()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("QueueItemCellID", forIndexPath: indexPath) as! QueueItemCell
        cell.queueItem  = queueItem(atIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.setSelected(false, animated: false)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let leaveAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Leave", handler: { (action, indexPath) -> Void in
            self.leaveQueue(indexPath);
        })
        leaveAction.backgroundColor = Constants.Colors.primaryColor
        return [leaveAction];
    }
    
    func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        self.dontRefresh = true
    }
    
    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        self.dontRefresh = false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    private func leaveQueue(indexPath:NSIndexPath){
        let q = queueItem(atIndexPath: indexPath)
        LeaveQueueOperation().run(q, callback: { raw, err in
            self.tableView.beginUpdates()
            SessionDataStore.sharedInstance.removeQueueItem(atIndex: indexPath.row)
            self.queue = SessionDataStore.sharedInstance.queue
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates()
        })
    }
    
    private func queueItem(atIndexPath indexPath:NSIndexPath) -> QueueItem{
        return queue[indexPath.row]
    }
    
}