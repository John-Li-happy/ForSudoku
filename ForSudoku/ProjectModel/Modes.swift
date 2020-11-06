//
//  Modes.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//

import Foundation

enum Modes: Int {
    case easy = 0
    case medium = 1
    case hard = 2
    case saved = 3
}

enum RunningMode {
    static var currentMode = Modes.easy
}
