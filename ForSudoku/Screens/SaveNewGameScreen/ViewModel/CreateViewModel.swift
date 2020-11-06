//
//  CreateViewModel.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//

import UIKit
import CoreData

class CreateViewModel {
    func createNewGame(addedMatrix: [[Int]], dateString: String, name: String, originalMatrix: [[Int]], timeDouble: Double, persentage: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        guard let oneNewGame = NSEntityDescription.insertNewObject(forEntityName: AppConstants.entityName, into: managedObjectContext) as? SavedGame else { return }
        oneNewGame.addedMatrix = addedMatrix
        oneNewGame.originalMatrix = originalMatrix
        oneNewGame.date = dateString
        oneNewGame.name = name
        oneNewGame.time = timeDouble
        oneNewGame.persentage = persentage
        
        do {
            try managedObjectContext.save()
        } catch { print("error in saving", error.localizedDescription) }
    }
}
