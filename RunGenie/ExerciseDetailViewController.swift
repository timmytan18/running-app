//
//  ExerciseDetailViewController.swift
//  RunGenie
//
//  Created by Tim Tan on 8/9/17.
//  Copyright © 2017 Tim Tan. All rights reserved.
//

import UIKit

class ExerciseDetailViewController: UIViewController {

    var descriptionLabel = ""
    
    @IBOutlet var exerciseDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseDescription.text = descriptionLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
