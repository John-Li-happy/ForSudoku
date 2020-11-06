//
//  LoadSavedGameViewController.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 11/4/20.
//

import UIKit

class LoadSavedGameViewController: UIViewController {
    let loadViewModel = LoadViewModel()
    let deleteViewModel = DeleteViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSavedGames()
    }
    
    private func fetchSavedGames() {
        loadViewModel.loadData { error in
            if error != nil {
            //error handler
            }
        }
    }
}

extension LoadSavedGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadViewModel.savedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.loadTableViewCell, for: indexPath) as? SavedGameTableViewCell else { return UITableViewCell() }
        let savedGame = loadViewModel.savedGames[indexPath.row]
        cell.configureCell(name: savedGame.name ?? "Unknown Game", savedTime: savedGame.date ?? "Unknown", process: savedGame.persentage ?? "Unknown")
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard = UIStoryboard(name: AppConstants.storyBoard, bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(identifier: AppConstants.mainViewController) as MainViewController
        mainViewController.savedGame = loadViewModel.savedGames[indexPath.row]
        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteViewModel.delete(game: loadViewModel.savedGames[indexPath.row])
            loadViewModel.loadData { error in
                tableView.reloadData()
            }
        }
    }
}
