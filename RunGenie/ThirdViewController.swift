//
//  ThirdViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/8/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var workout = ""
    
    @IBOutlet var workoutDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workoutDescription.text = workout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
