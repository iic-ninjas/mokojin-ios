//
//  CurrentMatchViewController.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class CurrentMatchViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var queueTableDelegate:QueueTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "AppLogo")
        self.navigationItem.titleView = UIImageView(image: image)
        self.queueTableDelegate = QueueTableDelegate(tableView: self.tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "chooseCharacterSegue" {
            if let vc = segue.destinationViewController as? SelectCharactersViewController {
                if let queueItemCell = sender as? QueueItemCell {
                    vc.player = queueItemCell.queueItem?.player
                }
            }
        }
    }
    
    @IBAction func unwindToCurrentMatch(segue: UIStoryboardSegue) {
        queueTableDelegate?.forceUpdate()
    }
    
    

    
}