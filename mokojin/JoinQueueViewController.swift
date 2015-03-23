//
//  JoinQueueViewController.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class JoinQueueViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var people:People = []
    let notificationManager = NotificationManager()
    
    override init() {
        super.init()
        self.listenOnEvents()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.listenOnEvents()
    }
    
    private func listenOnEvents(){
        notificationManager.registerObserver(PeopleStore.sharedInstance.NOTIFICATION_NAME, block: { notification in
            self.updateData()
        })
    }
    
    deinit {
        notificationManager.deregisterAll()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateData()
    }
    
    
    private func updateData(){
        self.people = PeopleStore.sharedInstance.people
        tableView.reloadData()
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCellID", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = people[indexPath.row].name
        
        return cell
    }


}