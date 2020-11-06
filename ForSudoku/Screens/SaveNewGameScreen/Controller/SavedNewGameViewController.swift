//
//  SavedNewGameViewController.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//

import UIKit

class SavedNewGameViewController: UIViewController {
    var originalMatrix = [[Int]]()
    var userModifiedMatrix = [[Int]]()
    var timeDouble = Double()
    var dateString = String()
    var persentageCounter = Int()
    let createViewModel = CreateViewModel()
    let loadViewModel = LoadViewModel()
    let deleteViewModel = DeleteViewModel()
    let updateViewModel = UpdateViewModel()
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialValueSettings()
        loadSavedGames()
    }
    
    @IBAction private func saveAtNewPosition(_ sender: UIButton) {
        // name getter
        var name = String()
        let alertController = UIAlertController(title: "New Game", message: "Please Type new game name here", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Please type new name here"
        }
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] (_) in
            guard let textFieldText = alertController?.textFields?.first?.text else { return }
            name = textFieldText.isEmpty ? "newGame" : textFieldText
            self.createViewModel.createNewGame(addedMatrix: self.userModifiedMatrix, dateString: self.dateString, name: name, originalMatrix: self.originalMatrix, timeDouble: self.timeDouble, persentage: "\(self.persentageCounter)%")
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func loadSavedGames() {
        loadViewModel.loadData { error in
            if error != nil {
                // error handler
            }
        }
    }
    
    private func initialValueSettings() {
        // date generater
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        dateString = formatter.string(from: Date())
        // persentage generater
        let _ = originalMatrix.map{ $0.map{ if $0 != 0 { persentageCounter += 1 } } }
        let _ = userModifiedMatrix.map{ $0.map{ if $0 != 0 { persentageCounter += 1 } } }
        persentageCounter = Int((Double(persentageCounter) / 81) * 100)

    }
}

extension SavedNewGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadViewModel.savedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.saveNewTableViewCell, for: indexPath) as? SavedGameTableViewCell else { return UITableViewCell() }
        let savedGame = loadViewModel.savedGames[indexPath.row]
        cell.configureCell(name: savedGame.name ?? "Unknown Game", savedTime: savedGame.date ?? "Unkonwn Time", process: savedGame.persentage ?? "Unknown%")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteViewModel.delete(game: loadViewModel.savedGames[indexPath.row])
            loadViewModel.loadData { error in
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var name = String()
        let alertController = UIAlertController(title: "Are you sure to recover this save?", message: "If do, please give a name and tap OK", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Please type new name here"
        }
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertUpdateAction = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let textFieldText = alertController.textFields?.first?.text else { return }
            name = textFieldText.isEmpty ? "newGame" : textFieldText
            self.updateViewModel.updateSavedGame(oldGame: self.loadViewModel.savedGames[indexPath.row], addedMatrix: self.userModifiedMatrix, dateString: self.dateString, name: name, originalMatrix: self.originalMatrix, timeDouble: self.timeDouble, persentage: "\(self.persentageCounter)%") { error in
                if error != nil {
                    // error handler
                    return
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(alertCancelAction)
        alertController.addAction(alertUpdateAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
