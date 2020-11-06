//
//  SecondLogic.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 10/28/20.
//

import Foundation

//private func randomBoardGeneratingSecondLogic() -> [[Int]] {
//    var outPutMatrix = [
//        [1, 2, 3, 4, 5, 6, 7, 8, 9],
//        [4, 5, 6, 7, 8, 9, 1, 2, 3],
//        [7, 8, 9, 1, 2, 3, 4, 5, 6],
//        [2, 3, 1, 5, 6, 4, 8, 9, 7],
//        [5, 6, 4, 8, 9, 7, 2, 3, 1],
//        [8, 9, 7, 2, 3, 1, 5, 6, 4],
//        [3, 1, 2, 6, 4, 5, 9, 7, 8],
//        [6, 4, 5, 9, 7, 8, 3, 1, 2],
//        [9, 7, 8, 3, 1, 2, 6, 4, 5]
//    ]
//
//    for _ in 0..<50 {
//        let chooser = Int.random(in: 0...1)
//        if chooser == 0 {
//            outPutMatrix = rowSwaper(inputMatrix: outPutMatrix)
//        } else {
//            outPutMatrix = columeSwapper(inputMatrix: outPutMatrix)
//        }
//    }
//    matrix = outPutMatrix
//    matrix = removeForFill(inputMatrix: outPutMatrix)
//    return outPutMatrix
//}

//private func rowSwaper(inputMatrix: [[Int]]) -> [[Int]] {
//    var outputMarix = [[Int]]()
//    let rowSet = Int.random(in: 0...2)
//    var sequence = [Int]()
//    switch rowSet {
//    case 0:
//        sequence = [0, 1, 2].shuffled()
//        for sequenceItem in 3..<9 { sequence.append(sequenceItem) }
//        
//    case 1:
//        sequence = [0, 1, 2]
//        sequence.append(contentsOf: [3, 4, 5].shuffled())
//        for sequenceItem in 6..<9 { sequence.append(sequenceItem) }
//    
//    default:
//        for sequenceItem in 0..<6 { sequence.append(sequenceItem) }
//        sequence.append(contentsOf: [6, 7, 8].shuffled())
//    }
//    for counter in 0..<sequence.count { outputMarix.append(inputMatrix[sequence[counter]]) }
//    print(inputMatrix)
//    print(outputMarix)
//    
//    return outputMarix
//}
//
//private func columeSwapper(inputMatrix: [[Int]]) -> [[Int]] {
//    var reverseRequiredMarix = [[Int]]()
//    let columeSet = Int.random(in: 0...2)
//    var sequence = [Int]()
//    var reversedMatrix = [[Int]]()
//    var accomplisedOutputMatrix = [[Int]]()
//    
//    for columeCounter in 0..<inputMatrix.count {
//        reversedMatrix.append([Int]())
//        for rowCounter in 0..<inputMatrix[0].count {
//            reversedMatrix[columeCounter].append(inputMatrix[rowCounter][columeCounter])
//        }
//    }
//    
//    switch columeSet {
//    case 0:
//        sequence = [0, 1, 2].shuffled()
//        for sequenceItem in 3..<9 { sequence.append(sequenceItem) }
//        
//    case 1:
//        sequence = [0, 1, 2]
//        sequence.append(contentsOf: [3, 4, 5].shuffled())
//        for sequenceItem in 6..<9 { sequence.append(sequenceItem) }
//    
//    default:
//        for sequenceItem in 0..<6 { sequence.append(sequenceItem) }
//        sequence.append(contentsOf: [6, 7, 8].shuffled())
//    }
//    for counter in 0..<sequence.count { reverseRequiredMarix.append(reversedMatrix[sequence[counter]]) }
//    
//    for columeCounter in 0..<reverseRequiredMarix.count {
//        accomplisedOutputMatrix.append([Int]())
//        for rowCounter in 0..<reverseRequiredMarix[0].count {
//            accomplisedOutputMatrix[columeCounter].append(reverseRequiredMarix[rowCounter][columeCounter])
//        }
//    }
//    print(inputMatrix)
//    print(accomplisedOutputMatrix)
//    return accomplisedOutputMatrix
//}
