//
//  SecondAndAHalfViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/9/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit

class SecondAndAHalfViewController: UIViewController {
    

    var workout = ""
    
    @IBOutlet var workoutDetails: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        workoutDetails.text = workout
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "segue1") {
            let thirdViewController = segue.destination as! ThirdViewController
            thirdViewController.workout = workout
        }
        else if segue.identifier == "segue3" {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
