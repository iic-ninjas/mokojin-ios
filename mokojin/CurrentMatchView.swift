//
//  CurrentMatchView.swift
//  mokojin
//
//  Created by Yonatan Bergman on 3/25/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation

class CurrentMatchView: UIView {

    @IBOutlet weak var playerA: PlayerCharactersView!
    @IBOutlet weak var playerALabel: UILabel!
    @IBOutlet weak var playerB: PlayerCharactersView!
    @IBOutlet weak var playerBLabel: UILabel!
    
    @IBOutlet weak var ratioBar: UIProgressView!
    @IBOutlet weak var ratioText: UILabel!

    var match:Match! {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        playerB.direction = .RightToLeft //Run once
        playerALabel.text = match.playerA.person.name
        playerBLabel.text = match.playerB.person.name
        playerA.player = match.playerA
        playerB.player = match.playerB
        ratioBar.progress = Float(match.chanceToWin)
        ratioText.text = RatioPresenter.ratioString(match)
    }

}
