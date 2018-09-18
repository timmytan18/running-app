//
//  SecondViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/5/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var runType = String()
    var workoutLength = String()
    var bestRaceType = String()
    var bestRaceTime = String()
    var trainingForType = String()
    var userIndex = Int()

    
    let mileList = ["5:00", "5:30", "6:00", "6:30", "7:00", "7:30", "8:00", "8:30", "9:00", "9:30", "10:00", "10:30", "11:00", "11:30", "12:00"]
    let fiveKList = ["5:30","6:00","6:30","7:05","7:40","8:05","8:40","9:10","9:40","10:15","10:40","11:15","11:40","12:15","12:40"]
    let tenKList = ["5:45","6:15","6:45","7:20","7:55","8:25","9:00","9:30","10:00","10:35","11:05","11:35","12:00","12:35","13:05"]
    let marathonList = ["6:15","6:50","7:25","8:00","8:35","9:10","9:45","10:15","10:50","11:25","12:00","12:35","13:00","13:20","13:45"]
    let tempoList = ["6:05","6:35","7:05","7:40","8:15","8:50","9:25","9:55","10:30","11:00","11:35","12:00","12:35","13:00","13:35"]
    let recoveryList = ["7:00","7:35","8:10","8:45","9:20","9:55","10:30","11:00","11:35","12:10","12:45","13:20","13:45","14:05","14:30"]
    
    var ref:DatabaseReference?
    
    var nikeList:[String] = []
    
    
    @IBOutlet var workoutList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workoutList.delegate = self
        workoutList.dataSource = self
        
        
        fillTable()
    }
    
    func fillTable() {
        
        //Database.database().isPersistenceEnabled = true
        
        ref = Database.database().reference()
        var count = 0
        
        ref?.child("RunningWorkouts").observeSingleEvent(of: .value, with: { (snapshot) in
            
            count = Int(snapshot.childrenCount)	
            for index in 0 ..< count {
            	
                let child = snapshot.childSnapshot(forPath: String(index))
                let race = child.childSnapshot(forPath: "Race")
                let type = child.childSnapshot(forPath: "Type")
                let description = child.childSnapshot(forPath: "Description")
                
                let raceString = String(describing: race.value!)
                let typeString = String(describing: type.value!)
                var descriptionString = String(describing: description.value!)
                
                var doesTimeMatter = false
                
                if self.workoutLength != "Over 60 min" {
                
                    if raceString == "Marathon" && typeString == "Endurance" {
                        let duration = child.childSnapshot(forPath: "Duration")
                        let durationString = String(describing: duration.value!)
                        if durationString == "yes" {
                            doesTimeMatter = true
                        }
                    }
                }
                
                if (raceString == self.trainingForType && typeString == self.runType) {
                    
                    if self.userIndex != -1 {
                    if descriptionString.lowercased().range(of:"mile pace") != nil || descriptionString.lowercased().range(of:"your mile pace") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "Mile pace", with: self.mileList[self.userIndex] + " min/mile")
                    }
                    
                    if descriptionString.lowercased().range(of:"5k pace") != nil || descriptionString.lowercased().range(of:"your 5k pace") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "5k pace", with: self.fiveKList[self.userIndex] + " min/mile")
                    }
                    
                    if descriptionString.lowercased().range(of:"10k pace") != nil || descriptionString.lowercased().range(of:"your 10k pace") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "10k pace", with: self.tenKList[self.userIndex] + " min/mile")
                    }
                    
                    if descriptionString.lowercased().range(of:"marathon pace") != nil || descriptionString.lowercased().range(of:"your marathon pace") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "Marathon pace", with: self.marathonList[self.userIndex] + " min/mile")
                    }
                    
                    if descriptionString.lowercased().range(of:"tempo pace") != nil || descriptionString.lowercased().range(of:"your tempo pace") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "Tempo pace", with: self.tempoList[self.userIndex] + " min/mile")
                    }
                    
                    if descriptionString.lowercased().range(of:"recovery pace") != nil || descriptionString.lowercased().range(of:"your recovery pace") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "Recovery pace", with: self.recoveryList[self.userIndex] + " min/mile")
                    }
                    
                    if descriptionString.range(of:"*") != nil {
                        descriptionString = descriptionString.replacingOccurrences(of: "*", with: self.recoveryList[self.userIndex+1] + "-" + self.recoveryList[self.userIndex+2] + " min/mile")
                    }
                    }
                    if doesTimeMatter == false {
                        self.nikeList.append(descriptionString)
                    }
                }
                DispatchQueue.main.async {
                    self.workoutList.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nikeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = nikeList[indexPath.row]
        cell.textLabel?.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.1237232313, green: 0.1770960093, blue: 0.2417519689, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: nikeList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as? SecondAndAHalfViewController
        send?.workout = sender as! String
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
