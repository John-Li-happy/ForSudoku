//
//  LoadViewModel.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//

import UIKit
import CoreData

class LoadViewModel {
    var savedGames = [SavedGame]()
    
    func loadData(aSimpleHandler handler: @escaping (Error?) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: AppConstants.entityName)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            guard let potentialGames = try managedObjectContext.fetch(fetchRequest) as? [SavedGame] else { return }
            savedGames = potentialGames
            handler(nil)
        } catch {
            print("error in reading", error.localizedDescription)
            handler(error)
        }
    }
}
