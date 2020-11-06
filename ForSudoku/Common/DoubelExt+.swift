//
//  DoubelExt+.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/3/20.
//

import Foundation

extension Double {
    func trunToValidString() -> String {
        return String(format: "%02ld:%02ld", Int(self) / 60, Int(self) % 60)
    }
}
