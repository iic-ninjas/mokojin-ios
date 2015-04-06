//
//  CurrentMatchViewController.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class CurrentMatchViewController : NotificationListenerViewController {
    

    
    @IBOutlet weak var emptyView: UILabel!
    @IBOutlet weak var matchView: CurrentMatchView!
    @IBOutlet weak var tableView: UITableView!
    
    var match:Match?
    

    var queueTableDelegate:QueueTableDelegate?
    
    var refreshControl:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "AppLogo")
        self.navigationItem.titleView = UIImageView(image: image)
        self.queueTableDelegate = QueueTableDelegate(tableView: self.tableView)

        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }

    func refresh(sender: AnyObject) {
        forceUpdate()
        self.refreshControl.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "chooseCharacterSegue" {
            if let vc = segue.destinationViewController as? SelectCharactersViewController {
                if let queueItemCell = sender as? QueueItemCell {
                    vc.player = queueItemCell.queueItem?.player
                } else if let player = sender as? Player {
                    vc.player = player
                }
            }
        }
    }
    
    @IBAction func unwindToCurrentMatch(segue: UIStoryboardSegue) {
        queueTableDelegate?.forceUpdate()
    }
    
    override func getNotificationName() -> String {
        return SessionDataStoreNotificationName
    }
    
    override func updateData() {
        if let match = SessionDataStore.sharedInstance.match {
            self.match = match
            emptyView.hidden = true
            matchView.match = match
            matchView.hidden = false
        } else {
            emptyView.hidden = false
            matchView.hidden = true
        }
    }
    
    func forceUpdate(){
        SessionDataStore.sharedInstance.forceUpdate()
    }
    
    @IBAction func didLongTapPlayerA(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            performSegueWithIdentifier("chooseCharacterSegue", sender: match?.playerA)
        }
    }
    
    @IBAction func didLongTapPlayerB(sender: AnyObject) {
        if sender.state == .Began {
            performSegueWithIdentifier("chooseCharacterSegue", sender: match?.playerB)
        }
    }

    @IBAction func didTapPlayerA(sender: UITapGestureRecognizer) {
        endMatch(WinnerEnum.PlayerA)
    }
    
    @IBAction func didTapPlayerB(sender: UITapGestureRecognizer) {
        endMatch(WinnerEnum.PlayerB)
    }
    
    private func endMatch(winner:WinnerEnum){
        ProgressHUD.show("Ending Match")
        EndMatchOperation().run(match!, winner: winner) { result, err in
            ProgressHUD.dismiss()
            self.forceUpdate()
        }
    }
}