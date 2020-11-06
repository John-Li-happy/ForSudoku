//
//  SavedGameTableViewCell.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//

import UIKit

class SavedGameTableViewCell: UITableViewCell {
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var savedTimeLabel: UILabel!
    @IBOutlet private weak var processLabel: UILabel!
    
    func configureCell(name: String, savedTime: String, process: String) {
        gameNameLabel.text = name
        savedTimeLabel.text = savedTime
        processLabel.text = process
    }
}
