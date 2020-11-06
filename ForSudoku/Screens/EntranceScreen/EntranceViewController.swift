//
//  EntranceViewController.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 10/28/20.
//

import UIKit

class EntranceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func easyButtonTapped(_ sender: Any) {
        RunningMode.currentMode = .easy
        navigateToPlayingViewController()
    }
    @IBAction func mediumButtonTapped(_ sender: Any) {
        RunningMode.currentMode = .medium
        navigateToPlayingViewController()
    }
    @IBAction func hardButtonTapped(_ sender: Any) {
        RunningMode.currentMode = .hard
        navigateToPlayingViewController()
    }
    @IBAction func savedGameButtonTapped(_ sender: Any) {
        RunningMode.currentMode = .saved
        let storyBoard = UIStoryboard(name: AppConstants.storyBoard, bundle: nil)
        guard let playingViewController = storyBoard.instantiateViewController(identifier: AppConstants.loadSavedGameViewController) as? LoadSavedGameViewController else { return }
        self.navigationController?.pushViewController(playingViewController, animated: true)
    }
    private func navigateToPlayingViewController() {
        let storyBoard = UIStoryboard(name: AppConstants.storyBoard, bundle: nil)
        guard let playingViewController = storyBoard.instantiateViewController(identifier: AppConstants.mainViewController) as? MainViewController else { return }
        self.navigationController?.pushViewController(playingViewController, animated: true)
    }
}
