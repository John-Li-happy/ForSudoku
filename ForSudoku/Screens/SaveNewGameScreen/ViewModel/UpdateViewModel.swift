//
//  UpdateViewModel.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/5/20.
//

import UIKit
import CoreData

class UpdateViewModel {
    func updateSavedGame(oldGame: SavedGame, addedMatrix: [[Int]], dateString: String, name: String, originalMatrix: [[Int]], timeDouble: Double, persentage: String, aSimpleHandler handler: @escaping (Error?) -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        oldGame.addedMatrix = addedMatrix
        oldGame.date = dateString
        oldGame.name = name
        oldGame.originalMatrix = originalMatrix
        oldGame.time = timeDouble
        oldGame.persentage = persentage

        do {
            try managedObjectContext.save()
            handler(nil)
        } catch {
            handler(error)
            print("error in saving", error.localizedDescription)
        }
    }
}
