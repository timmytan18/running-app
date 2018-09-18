//
//  ExercisesViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/9/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExercisesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref:DatabaseReference?
    
    var exerciseList:[String] = []
    
    var descriptionList:[String] = []
    
    var descriptionToSend = ""
    
    @IBOutlet var exercisesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercisesTable.delegate = self
        exercisesTable.dataSource = self
        
        fillTable()

    }
    
    func fillTable() {
        ref = Database.database().reference()
        var count = 0
        ref?.child("StrengthExercises").observeSingleEvent(of: .value, with: { (snapshot) in
            
            count = Int(snapshot.childrenCount)
            for index in 0 ..< count {
                
                let child = snapshot.childSnapshot(forPath: String(index))
                let name = child.childSnapshot(forPath: "ExerciseName")
                let description = child.childSnapshot(forPath: "Description")
                
                let nameString = String(describing: name.value!)
                let descriptionString = String(describing: description.value!)
                
                self.descriptionList.append(descriptionString)
                self.exerciseList.append(nameString)
            }
            DispatchQueue.main.async {
                self.exercisesTable.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = exerciseList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        descriptionToSend = descriptionList[indexPath.row]
        performSegue(withIdentifier: "segue", sender: exerciseList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let exerciseDetailViewController = segue.destination as! ExerciseDetailViewController	
        exerciseDetailViewController.descriptionLabel = descriptionToSend
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
