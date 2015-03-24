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
    
    let queueTableDelegate = QueueTableDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "AppLogo")
        self.navigationItem.titleView = UIImageView(image: image)
        
        self.tableView.delegate = queueTableDelegate
        self.tableView.dataSource = queueTableDelegate
    }
    
}