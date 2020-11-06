//
//  CollectionViewCell.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 10/27/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    
    func configureCell(digit: Int, inComingSourseFlag: Int) { // 0 means orignial, 1 means added
        if inComingSourseFlag == 0 {
            self.isUserInteractionEnabled = false
            numberLabel.text = String(digit)
            numberLabel.textColor = UIColor.blue

        } else {
            self.isUserInteractionEnabled = true
            
            if digit == 0 {
                numberLabel.text = "  "
            } else {
                numberLabel.text = String(digit)
                numberLabel.textColor = UIColor.black
            }
        }
    }
}
