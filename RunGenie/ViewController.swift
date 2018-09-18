//
//  ViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/2/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var begBtn: UIButton!
    @IBOutlet weak var interBtn: UIButton!
    @IBOutlet weak var advBtn: UIButton!
    
    var type = ""
    
    var userIndex = -1
    
    @IBAction func begPressed(_ sender: Any) {
        if (!interBtn.isHidden && !advBtn.isHidden) {
            type = "Speed"
            interBtn.isHidden = true
            advBtn.isHidden = true
        }
        else if (interBtn.isHidden && advBtn.isHidden) {
            begBtn.isHidden = false
            interBtn.isHidden = false
            advBtn.isHidden = false
            type = ""
        }
    }
    
    @IBAction func interPressed(_ sender: Any) {
        if (!begBtn.isHidden && !advBtn.isHidden) {
            type = "Endurance"
            begBtn.isHidden = true
            advBtn.isHidden = true
        }
        else if (begBtn.isHidden && advBtn.isHidden) {
            begBtn.isHidden = false
            interBtn.isHidden = false
            advBtn.isHidden = false
            type = ""
        }
    }
    
    @IBAction func advPressed(_ sender: Any) {
        if (!begBtn.isHidden && !interBtn.isHidden) {
            type = "Recovery"
            begBtn.isHidden = true
            interBtn.isHidden = true
        }
        else if (begBtn.isHidden && interBtn.isHidden) {
            begBtn.isHidden = false
            interBtn.isHidden = false
            advBtn.isHidden = false
            type = ""
        }
    }
    
    
    @IBOutlet weak var bestRaceTimeLabel: UILabel!
    
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBOutlet weak var selectTimeBtn: UIButton!
    
    @IBOutlet weak var selectRaceTypeBtn: UIButton!
    
    @IBOutlet weak var raceTypePicker: UIPickerView!
    
    @IBOutlet weak var selectRaceTimeBtn: UIButton!
    
    @IBOutlet weak var raceTimePicker: UIPickerView!
    
    @IBOutlet weak var selectTrainingTypeBtn: UIButton!
    
    @IBOutlet weak var raceTypePicker2: UIPickerView!
    
    
    
    @IBAction func timePressed(_ sender: Any) {
        timePicker.isHidden = false
    }
    
    @IBAction func raceTypePressed(_ sender: Any) {
        selectRaceTimeBtn.setTitle("Select time...", for: .normal)
        selectRaceTimeBtn.isHidden = true
        raceTypePicker.isHidden = false
    }
    
    @IBAction func raceTimePressed(_ sender: Any) {
        raceTimePicker.isHidden = false
    }
    
    @IBAction func raceType2Pressed(_ sender: Any) {
        raceTypePicker2.isHidden = false
    }
    
    let workoutTime = ["Under 30 min", "30 to 60 min", "Over 60 min"]
    
    let raceTypeList = ["Mile", "5K", "10K", "Half Marathon", "Marathon"]
    
    let mileList = ["5:00", "5:30", "6:00", "6:30", "7:00", "7:30", "8:00", "8:30", "9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00"]
    let fiveKList = ["17:05", "18:45", "20:15", "22:00", "23:45", "25:15", "27:00", "28:30", "30:00", "31:45", "33:00", "35:00", "36:15", "38:00", "39:30"]
    let tenKList = ["35:45", "39:00", "42:00", "45:45", "49:00", "52:30", "55:50", "59:00", "1:02:30", "1:06:00", "1:09:00", "1:12:00", "1:15:00", "1:18:30", "1:21:30"]
    let halfMarathonList = ["1:18:00", "1:25:00", "1:35:00", "1:40:00", "1:50:00", "1:55:00", "2:05:00", "2:10:00", "2:20:00", "2:25:00", "2:35:00", "2:40:00", "2:50:00", "2:55:00", "3:05:00"]
    let marathonList = ["2:44:00", "3:00:00", "3:15:00", "3:30:00", "3:45:00", "4:00:00", "4:15:00", "4:30:00", "4:45:00", "5:00:00", "5:15:00", "5:30:00", "5:40:00", "5:50:00", "6:00:00"]
    
    let raceTypeList2 = ["Mile", "5K", "10K", "Half Marathon", "Marathon"]
    
    var typeCase = -1
    
    var workoutLength = ""
    
    var raceType = ""
    
    var raceTime = ""
    
    var trainingType = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows = workoutTime.count
        if pickerView == raceTypePicker {
            countrows = raceTypeList.count
        }
        else if pickerView == raceTimePicker {
            switch self.typeCase {
            case 0:
                countrows = self.mileList.count
            case 1:
                countrows = self.fiveKList.count
            case 2:
                countrows = self.tenKList.count
            case 3:
                countrows = self.halfMarathonList.count
            case 4:
                countrows = self.marathonList.count
            default:
                countrows = self.mileList.count
            }
        }
        else if pickerView == raceTypePicker2 {
            countrows = raceTypeList2.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timePicker {
            return workoutTime[row]
        }
        else if pickerView == raceTypePicker{
            return raceTypeList[row]
        }
        else if pickerView == raceTimePicker {
            switch self.typeCase {
            case 0:
                return self.mileList[row]
            case 1:
                return self.fiveKList[row]
            case 2:
                return self.tenKList[row]
            case 3:
                return self.halfMarathonList[row]
            case 4:
                return self.marathonList[row]
            default:
                return self.mileList[row]
            }
        }
        else if pickerView == raceTypePicker2 {
            return raceTypeList2[row]
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == timePicker {
            selectTimeBtn.setTitle(workoutTime[row], for: .normal)
            timePicker.isHidden = true
            workoutLength = workoutTime[row]
        }
        else if pickerView == raceTypePicker{
            selectRaceTypeBtn.setTitle(raceTypeList[row], for: .normal)
            raceTypePicker.isHidden = true
            selectRaceTimeBtn.isHidden = false
            typeCase = row
            raceType = raceTypeList[row]
        }
        else if pickerView == raceTimePicker {
            switch self.typeCase {
            case 0:
                selectRaceTimeBtn.setTitle(mileList[row], for: .normal)
                raceTime = mileList[row]
                userIndex = row
            case 1:
                selectRaceTimeBtn.setTitle(fiveKList[row], for: .normal)
                raceTime = fiveKList[row]
                userIndex = row
            case 2:
                selectRaceTimeBtn.setTitle(tenKList[row], for: .normal)
                raceTime = tenKList[row]
                userIndex = row
            case 3:
                selectRaceTimeBtn.setTitle(halfMarathonList[row], for: .normal)
                raceTime = halfMarathonList[row]
                userIndex = row
            case 4:
                selectRaceTimeBtn.setTitle(marathonList[row], for: .normal)
                raceTime = marathonList[row]
                userIndex = row
            default:
                selectRaceTimeBtn.setTitle("--", for: .normal)
            }
            raceTimePicker.isHidden = true
        }
        else if pickerView == raceTypePicker2 {
            selectTrainingTypeBtn.setTitle(raceTypeList2[row], for: .normal)
            raceTypePicker2.isHidden = true
            trainingType = raceTypeList2[row]
        }
    }
    
    @IBOutlet var nextPageBtn: UIBarButtonItem!
    
    @IBAction func nxtPg(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as! SecondViewController
        secondController.runType = type
        secondController.workoutLength = workoutLength
        secondController.bestRaceType = raceType
        secondController.bestRaceTime = raceTime
        secondController.trainingForType = trainingType
        secondController.userIndex = userIndex
    }
}

