//
//  QueueItemCell.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/24/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class QueueItemCell : UITableViewCell {
    
    @IBOutlet weak var playerCharacterView: PlayerCharactersView!
    @IBOutlet weak var queuedTimeLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var queueItem:QueueItem? {
        didSet {
            if let queueItem = self.queueItem {
                playerNameLabel.text = queueItem.player.person.name
                queuedTimeLabel.text = QueuePresenter.timeago(queueItem.createdAt!)
                playerCharacterView.player = queueItem.player
               
            }
        }
    }
    
}
