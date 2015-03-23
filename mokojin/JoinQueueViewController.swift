//
//  JoinQueueViewController.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class JoinQueueViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {
    
    @IBOutlet var tableView: UITableView!
    var people:People = []
    var searchResults:People = []
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
        notificationManager.registerObserver(PeopleStoreNotificationName, block: { notification in
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
        if inSearchResults(tableView){
            return searchResults.count
        } else {
            return people.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PlayerCellID", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = personAtIndex(tableView, indexPath: indexPath).name
        return cell
    }

    func personAtIndex(tableView: UITableView, indexPath: NSIndexPath) -> Person {
        if inSearchResults(tableView){
            return searchResults[indexPath.row]
        } else {
            return people[indexPath.row]
        }
    }

    func inSearchResults(tableView: UITableView) -> Bool{
        return tableView == searchDisplayController?.searchResultsTableView
    }


    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool{
        self.searchResults = self.people.filter {
            $0.name.hasPrefix(searchString)
        }
        return true
    }

}