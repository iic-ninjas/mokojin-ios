//
//  SelectCharactersViewController.swift
//  mokojin
//
//  Created by Assaf Gelber on 3/23/15.
//  Copyright (c) 2015 iicninjas. All rights reserved.
//

import Foundation
import UIKit

class SelectCharactersViewController: NotificationListenerViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    typealias CharacterSelection = (character: Character, indexPath: NSIndexPath)
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var player:Player?
    var characters:[Character] = []
    var firstSelection:CharacterSelection?
    var secondSelection:CharacterSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
        updateDoneButton()
    }
    
    override func getNotificationName() -> String {
        return CharacterStoreNotificationName
    }
    
    override func updateData() {
        if CharacterStore.sharedInstance.loaded {
            ProgressHUD.dismiss()
            self.characters = CharacterStore.sharedInstance.characters
            UIView.animateWithDuration(0, animations: {
                self.collectionView.reloadData()
            }, completion: { bool in
                self.findExistingCharacters()
            })
        } else {
            ProgressHUD.show()
        }
    }
    
    // MARK: Done button
    
    @IBAction func donePressed(sender: AnyObject) {
        if (player != nil && firstSelection != nil){
            ProgressHUD.show("Setting Characters")
            SetCharactersOperation().run(player!, characterA: firstSelection!.character, characterB: secondSelection?.character, callback: {
                raw, err in
                ProgressHUD.dismiss()
                self.done()
            })
        }
    }
    
    func done(){
        performSegueWithIdentifier("unwindToCurrentMatch", sender: self)
    }
    
    private func updateDoneButton(){
        doneButton.enabled = (self.firstSelection != nil)
    }
    
    // MARK: CollectionViewDelegate & CollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CharacterCellID", forIndexPath: indexPath) as CharacterCellView
        if let character = character(indexPath: indexPath){
            cell.characterView.character = character
            cell.performSelectionAnimations()
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        addSelection(indexPath)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CharacterCellView {
            cell.performSelectionAnimations()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        removeSelection(indexPath)
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? CharacterCellView {
            cell.performSelectionAnimations()
        }
    }
    
    private func character(#indexPath: NSIndexPath) -> Character?{
        return self.characters[indexPath.row]
    }
    
    private func characterSelection(#indexPath: NSIndexPath) -> CharacterSelection? {
        if let character = self.character(indexPath: indexPath) {
            return (character, indexPath)
        } else {
            return nil
        }
    }

    
    // MARK: Selection Logic
    
    private func isCharacterSelected(character: Character) -> Bool {
        return (self.firstSelection?.character == character ||
                self.secondSelection?.character == character)
    }
    
    private func addSelection(indexPath: NSIndexPath) {
        if let newSelection = characterSelection(indexPath: indexPath) {
            if self.firstSelection == nil {
                self.firstSelection = newSelection
            } else {
                if let selection = self.secondSelection {
                    deselectCellAtIndexPath(selection.indexPath)
                }
                self.secondSelection = self.firstSelection
                self.firstSelection = newSelection
            }
        }
        updateDoneButton()
    }
    
    private func selectCellAtIndexPath(indexPath: NSIndexPath) {
        collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.Top)
        collectionView(self.collectionView, didSelectItemAtIndexPath: indexPath)
    }
    
    private func deselectCellAtIndexPath(indexPath: NSIndexPath){
        self.collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        collectionView(self.collectionView, didDeselectItemAtIndexPath: indexPath)
    }
    
    private func removeSelection(indexPath: NSIndexPath) {
        if let character = character(indexPath: indexPath) {
            if self.secondSelection != nil && self.secondSelection!.character == character {
                self.secondSelection = nil
            } else if self.firstSelection != nil && self.firstSelection!.character == character {
                self.firstSelection = self.secondSelection
                self.secondSelection = nil
            }
        }
        updateDoneButton()
    }
    
    // MARK: Preloading logic
    
    private func findExistingCharacters(){
        if let existingPlayer = player {
            findExistingCharacter(existingPlayer.characterA)
            findExistingCharacter(existingPlayer.characterB)
        }
    }
    
    private func findExistingCharacter(existingCharacter: Character?) {
        if let character = existingCharacter {
            if let index = find(self.characters, character) {
                let indexPath = NSIndexPath(forItem: index, inSection: 0)
                selectCellAtIndexPath(indexPath)
            }
        }
    }
}