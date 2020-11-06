//
//  DeleteViewModel.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/5/20.
//

import UIKit
import CoreData

struct DeleteViewModel {
    func delete(game: SavedGame) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        managedObjectContext.delete(game)
        do {
            try managedObjectContext.save()
        } catch { print("error in deleting", error.localizedDescription) }
    }
}
