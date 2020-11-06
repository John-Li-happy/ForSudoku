//
//  MainViewController.swift
//  ForSudoku
//
//  Created by Zhaoyang Li on 10/27/20.
//

import UIKit

class MainViewController: UIViewController {
    let viewModel = ViewModel()
    var initialArray = [[Int]]()
    let viewSize = UIScreen.main.bounds.width - 1
    let numberArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var chosenIndex = Int()
    var timeCounter = 0.0
    var savedGame: SavedGame?
    
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var numberPickerView: UIPickerView! {
        didSet {
            numberPickerView.delegate = self
            numberPickerView.dataSource = self
            numberPickerView.isHidden = true
        }
    }
    @IBOutlet private weak var cheetSheetLabel: UILabel! {
        didSet {
            cheetSheetLabel.isHidden = false
        }
    }
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var cheetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSettings()
    }
    
    private func initialSettings() {
        Flags.loadedFlag = false
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(cheetSheetInfo), userInfo: nil, repeats: true)
        
        viewModel.generatingBoard(savedGame: savedGame) { error in
            DispatchQueue.main.async {
                if error != nil {
                    let alertController = UIAlertController(title: "Title", message: "Error in loading", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timerHandler), userInfo: nil, repeats: true)
                Flags.loadedFlag = true
                self.timeCounter = self.viewModel.continueTimer
            }
        }
    }
    
    @IBAction private func cheetButtonTapped(_ sender: Any) {
        cheetView.isHidden = false
    }
    
    @IBAction private func closeButtonTapped(_ sender: Any) {
        cheetView.isHidden = true
    }
    
    @IBAction private func checkButtonTapped(_ sender: Any) {
        var alertController = UIAlertController()
        var alertAction = UIAlertAction()
        if viewModel.checkValidility() {
            alertController = UIAlertController(title: "Congrates", message: "You ve passed this puzzle", preferredStyle: .alert)
            alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                //Later done
            })
        } else {
            alertController = UIAlertController(title: "Sorry", message: "There are something wrong in your solution", preferredStyle: .alert)
            alertAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                //Later done
            })
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction private func saveButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: AppConstants.storyBoard, bundle: nil)
        guard let saveViewController = storyBoard.instantiateViewController(identifier: AppConstants.savedGamesViewController) as? SavedNewGameViewController else { return }
        saveViewController.originalMatrix = viewModel.originalMatrix
        saveViewController.userModifiedMatrix = viewModel.userAddedMatrix
        saveViewController.timeDouble = timeCounter
        self.navigationController?.pushViewController(saveViewController, animated: true)
    }
    
    @objc func timerHandler(time: TimeInterval) {
        timeCounter += 0.1
        timerLabel.text = timeCounter.trunToValidString()
    }
    
    @objc private func cheetSheetInfo() {
        var cheetString = "CheetSheet:\n"
        var digitBase = [Int]()
        // create digit base
        for _ in 0..<9 { digitBase.append(9) }
        for row in viewModel.originalMatrix {
            for element in row where element != 0{ digitBase[element - 1] -= 1 }
        }
        
        // create string
        for element in 0..<digitBase.count {
            cheetString.append("  - \(digitBase[element]) left for digit \(element + 1)\n")
        }
        cheetSheetLabel.text = cheetString
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 81
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.collectionViewCell, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        if viewModel.originalMatrix[indexPath.row / 9][indexPath.row % 9] != 0 {
            cell.configureCell(digit: viewModel.originalMatrix[indexPath.row / 9][indexPath.row % 9], inComingSourseFlag: 0)
        } else {
            cell.configureCell(digit: viewModel.userAddedMatrix[indexPath.row / 9][indexPath.row % 9], inComingSourseFlag: 1)
        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected", indexPath.row)
        chosenIndex = indexPath.row
        numberPickerView.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewSize / 9, height: viewSize / 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0001
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0001
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.userAddedMatrix[chosenIndex / 9][chosenIndex % 9] = Int(numberArray[row]) ?? 0
        numberPickerView.isHidden = true
        collectionView.reloadItems(at: [IndexPath(row: chosenIndex, section: 0)])
    }
}
