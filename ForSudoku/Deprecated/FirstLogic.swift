//
//  FirstLogic.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 10/28/20.
//

import Foundation

// First logic
//        var counter = 0
//        var sectorFlag = false
//        while sectorFlag == false {
//            print(counter)
//            outPutArray = randomBoardGenratingFirstLogic()
//            sectorFlag = checkValidility(inputArray: outPutArray)
//            counter += 1
//        }

//private func randomBoardGenratingFirstLogic() -> [[Int]] {
//    var outPutArray = [[Int]]()
//    var rowCorrectFlag = false
//    let sampleArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]
//    let firstRow = sampleArray.shuffled()
//    outPutArray.append(firstRow)
//
//    for columeCounter in 1..<9 {
//        rowCorrectFlag = false
//        var possibleNewRow = [Int]()
//        while rowCorrectFlag == false {
//            possibleNewRow = sampleArray.shuffled()
//            outPutArray.append(possibleNewRow)
//            var corretCoutner = 0
//            for eachColumeIndex in 0..<9 {
//                let colume = outPutArray.map{ $0[eachColumeIndex] }
//                if Set(colume).count == columeCounter + 1 {
//                    corretCoutner += 1
//                }
//            }
//            if corretCoutner == 9 {
//                rowCorrectFlag = true
//            }
//            outPutArray.remove(at: outPutArray.count - 1)
//        }
//        outPutArray.append(possibleNewRow)
//    }
//    return outPutArray
//}
