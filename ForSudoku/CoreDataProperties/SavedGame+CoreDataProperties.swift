//
//  SavedGame+CoreDataProperties.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//
//

import Foundation
import CoreData


extension SavedGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedGame> {
        return NSFetchRequest<SavedGame>(entityName: "SavedGame")
    }

    @NSManaged public var addedMatrix: [[Int]]?
    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var originalMatrix: [[Int]]?
    @NSManaged public var persentage: String?
    @NSManaged public var time: Double

}

extension SavedGame : Identifiable {

}
