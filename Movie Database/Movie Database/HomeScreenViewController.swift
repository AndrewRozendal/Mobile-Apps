//
//  ViewController.swift
//  Movie Database
//
//  Created by Andrew Rozendal on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    // MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "randomSelected" {
            print("detected random")
            //TODO Do something here!
            //Need to programatically get access to the array of movies and do a math.random() on it
            //Currently, the table is the only viewcontroller that knows about the data model.  Should fix that.
        }
    }
    
}

