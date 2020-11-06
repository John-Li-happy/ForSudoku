//
//  GenerationViewModel.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 10/27/20.
//

import Foundation
import UIKit

class ViewModel {
    var originalMatrix = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    var userAddedMatrix = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    let puzzleSize = 9
    let sizeSRN = 3
    let removeNumber = 20
    var continueTimer = 0.0
    
    func generatingBoard(savedGame: SavedGame?, aSimpleHandler handler: @escaping (Error?) -> ()) {
        //Third Logic
        if RunningMode.currentMode == .saved {
            guard let validSavedGame = savedGame else { return }
            loadSavedGame(savedGame: validSavedGame)
        } else {
            fillDiagonal()
            let _ = fillNonDiagonal(row: 0, colume: sizeSRN)
            removeForFill()
        }
        handler(nil)
    }
    
    private func loadSavedGame(savedGame: SavedGame) {
        originalMatrix = savedGame.originalMatrix ?? [[Int]]()
        userAddedMatrix = savedGame.addedMatrix ?? [[Int]]()
        continueTimer = savedGame.time 
    }
    
    private func fillDiagonal() {
        for counter in stride(from: 0, to: puzzleSize, by: sizeSRN) {
            fillbox(row: counter, colume: counter)
        }
    }
    
    private func fillNonDiagonal(row: Int, colume: Int) -> Bool {
        var row = row
        var colume = colume
        if colume >= puzzleSize && row < puzzleSize - 1 {
            row += 1
            colume = 0
        }
        if row >= puzzleSize && colume >= puzzleSize { return true }
        if row < sizeSRN {
            if colume < sizeSRN { colume = sizeSRN }
        } else if row < puzzleSize - sizeSRN {
            if colume == (row / sizeSRN) * sizeSRN { colume += sizeSRN }
        } else {
            if colume == puzzleSize - sizeSRN{
                row += 1
                colume = 0
                if row >= puzzleSize { return true }
            }
        }
        
        for couter in 1...puzzleSize {
            if checkIfSafe(row: row, colume: colume, number: couter) {
                originalMatrix[row][colume] = couter
                if fillNonDiagonal(row: row, colume: colume + 1) { return true }
                originalMatrix[row][colume] = 0
            }
        }
        
        return false
    }
    
    private func checkIfSafe(row: Int, colume: Int, number: Int) -> Bool {
        return unUsedInRow(row: row, number: number) && unUsedInColume(colume: colume, number: number) && unUsedBox(rowStarter: row - row % sizeSRN, columeStarter: colume - colume % sizeSRN, number: number)
    }
    
    private func unUsedInRow(row: Int, number: Int) -> Bool {
        for colume in 0..<puzzleSize where originalMatrix[row][colume] == number { return false }
        return true
    }
    
    private func unUsedInColume(colume: Int, number: Int) -> Bool {
        for row in 0..<puzzleSize where originalMatrix[row][colume] == number { return false }
        return true
    }
    
    private func fillbox(row: Int, colume: Int) {
        var number = 0
        for rowCounter in 0..<sizeSRN {
            for columeCounter in  0..<sizeSRN {
                repeat {
                    number = Int.random(in: 1...9)
                } while !unUsedBox(rowStarter: row, columeStarter: colume, number: number)
                originalMatrix[row + rowCounter][colume + columeCounter] = number
            }
        }
    }
    
    private func unUsedBox(rowStarter: Int, columeStarter: Int, number: Int) -> Bool {
        for rowCounter in 0..<sizeSRN {
            for columeCounter in 0..<sizeSRN {
                if originalMatrix[rowStarter + rowCounter][columeStarter + columeCounter] == number { return false }
            }
        }
        return true
    }

    func printMatrix() {
        for row in 0..<puzzleSize {
            for colume in 0..<puzzleSize {
                print(" ", originalMatrix[row][colume])
            }
            print("\n")
        }
    }
    
    private func removeForFill() {
        var removedDigits = 0
        switch RunningMode.currentMode {
        case .easy:
            removedDigits = 40
        case .medium:
            removedDigits = 45
        case .hard:
            removedDigits = 55
        case .saved:
            removedDigits = 0
        }
        
        while checkZeros() < removedDigits {
            let randomNumber = Int.random(in: 0..<81)
            originalMatrix[randomNumber / 9][randomNumber % 9] = 0
        }
    }
    
    private func checkZeros() -> Int {
        var counter = 0
        let _ = originalMatrix.flatMap{ $0.map{ if $0 == 0 { counter += 1 } } }
        return counter
    }

    func checkValidility() -> Bool {
        let correctSet: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        var checkingArray = [Int]()
        // Row check
        for row in originalMatrix {
            let rowSet = Set(row)
            if rowSet != correctSet { return false }
        }
        // Colume Check
        for columeIndex in 0..<originalMatrix.count {
            let columeArray: Set = Set(originalMatrix.map{ $0[columeIndex] })
            if columeArray != correctSet { return false }
        }
        // Sector Check
        for columeCounter in stride(from: 0, to: originalMatrix.count, by: 3) {
            for rowCounter in stride(from: 0, to: originalMatrix.count, by: 3) {
                for sectorColumeCoutner in 0..<3 {
                    for sectorRowCounter in 0..<3 {
                        checkingArray.append(originalMatrix[columeCounter + sectorColumeCoutner][rowCounter + sectorRowCounter])
                    }
                }
                if Set(checkingArray) != correctSet { return false }
                checkingArray = [Int]()
            }
        }
        return true
    }
}

