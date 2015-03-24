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
    
    @IBOutlet weak var collectionView: UICollectionView!
    var characters:[Character] = []
    var firstSelection:CharacterSelection?
    var secondSelection:CharacterSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = true
    }
    
    override func getNotificationName() -> String {
        return CharacterStoreNotificationName
    }
    
    override func updateData() {
        self.characters = CharacterStore.sharedInstance.characters
        self.collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    // MARK: CollectionViewDelegate & CollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CharacterCellID", forIndexPath: indexPath) as CharacterCellView
        let character = self.characters[indexPath.row]
        cell.characterView.character = character
        cell.isSelected = isCharacterSelected(character)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell:CharacterCellView = collectionView.cellForItemAtIndexPath(indexPath) as CharacterCellView
        addSelection((cell.characterView.character, indexPath))
        cell.isSelected = true
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell:CharacterCellView = collectionView.cellForItemAtIndexPath(indexPath) as CharacterCellView
        removeSelection(cell.characterView.character)
        cell.isSelected = false
    }
    
    // MARK: Selection Logic
    
    private func isCharacterSelected(character: Character) -> Bool {
        return (self.firstSelection?.character == character || self.secondSelection?.character == character)
    }
    
    private func addSelection(newSelection: CharacterSelection) {
        if self.firstSelection == nil {
            self.firstSelection = newSelection
        } else {
            if let selection = self.secondSelection {
                self.collectionView.deselectItemAtIndexPath(selection.indexPath, animated: true)
                (self.collectionView.cellForItemAtIndexPath(selection.indexPath) as? CharacterCellView)?.isSelected = false
            }
            self.secondSelection = self.firstSelection
            self.firstSelection = newSelection
        }
    }
    
    private func removeSelection(character: Character) {
        if self.secondSelection != nil && self.secondSelection!.character == character {
            self.secondSelection = nil
        } else if self.firstSelection != nil && self.firstSelection!.character == character {
            self.firstSelection = self.secondSelection
            self.secondSelection = nil
        }
    }
}