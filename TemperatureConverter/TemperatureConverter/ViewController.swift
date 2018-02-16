//
//  ViewController.swift
//  TemperatureConverter
//
//  Created by MacBook on 2018-02-16.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var desiredConversionChoice: UISegmentedControl!
    @IBOutlet weak var valueToConvertField: UITextField!
    @IBOutlet weak var resultField: UILabel!
    
    //Mark: Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func convertValueBtn(_ sender: Any) {
        if let value = self.valueToConvertField.text {
            if self.desiredConversionChoice.selectedSegmentIndex == 0 {
                // Conversion 1
                self.resultField.text = "Conversion 1 with \(value)"
            } else {
                // Conversion 2
                self.resultField.text = "Conversion 2 with \(value)"
            }
        } else {
            //Text Field was nil
            self.resultField.text = "N/A"
        }
    }
    

}

