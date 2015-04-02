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
    var searchQuery:String = ""
    let notificationManager = ObservationManager()
    
    @IBOutlet weak var emptyView: UILabel!
    
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
        notificationManager.registerObserver(SessionDataStoreNotificationName, block: { notification in
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
        let allPeople = PeopleStore.sharedInstance.people
        let playingPeople = SessionDataStore.sharedInstance.currentPlayingPeople()
        self.people = allPeople.filter {
            !contains(playingPeople, $0)
        }
        emptyView.hidden = !self.people.isEmpty
        tableView.hidden = self.people.isEmpty
        tableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return inSearchResults(tableView) && searchQueryIsNewPlayer() ? 1 : 0
        case 1 :
            if inSearchResults(tableView){
                return searchResults.count
            } else {
                return people.count
            }
        default:
            assertionFailure("Table only supports up to 2 sections")
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0: addNewPerson()
        case 1: addExistingPerson(personAtIndex(tableView, indexPath: indexPath))
        default: assertionFailure("Table only supports up to 2 sections")
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PlayerCellID") as UITableViewCell
        switch indexPath.section {
        case 0: cell.textLabel?.text = "Add new player '\(self.searchQuery)'"
        case 1: cell.textLabel?.text = personAtIndex(tableView, indexPath: indexPath).name
        default: assertionFailure("Table only supports up to 2 sections")
        }
        
        return cell
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool{
        self.searchQuery = searchString
        self.searchResults = self.people.filter {
            $0.name.lowercaseString.hasPrefix(searchString.lowercaseString)
        }
        return true
    }
    
    private func addNewPerson(){
        ProgressHUD.show("Creating new user")
        let name = self.searchQuery
        CreatePersonOperation().run(name, callback: { (raw, err) -> Void in
            PeopleStore.sharedInstance.forceUpdate()
            if let person = raw as? Person {
                self.addExistingPerson(person)
            } else {
                ProgressHUD.dismiss()
            }
        })
    }
    
    private func addExistingPerson(person:Person){
        ProgressHUD.show("Adding to Queue")
        JoinQueueOperation().run(person, callback: { (result, err) -> Void in
            ProgressHUD.dismiss()
            self.done()
        })    
    }
    
    private func done(){
        self.performSegueWithIdentifier("unwindToCurrentMatch", sender: self)
    }
    
    private func personAtIndex(tableView: UITableView, indexPath: NSIndexPath) -> Person {
        if inSearchResults(tableView){
            return searchResults[indexPath.row]
        } else {
            return people[indexPath.row]
        }
    }
    
    private func inSearchResults(tableView: UITableView) -> Bool{
        return tableView == searchDisplayController?.searchResultsTableView
    }
    
    private func searchQueryIsNewPlayer() -> Bool{
        if searchQuery.isEmpty {
            return false
        } else {
            return self.people.filter{ $0.name.lowercaseString == self.searchQuery.lowercaseString }.isEmpty
        }
    }
    
}