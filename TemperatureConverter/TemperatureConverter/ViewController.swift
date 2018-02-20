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
    var test = ""
    // Identifies user conversion choice
    @IBOutlet weak var desiredConversionChoice: UISegmentedControl!
    // Field for user value to convert
    @IBOutlet weak var valueToConvertField: UITextField!
    // Label to hold end result
    @IBOutlet weak var resultField: UILabel!
    
    //Mark: Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.resultField.text = test
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    // Called when convert button pressed
    // Converts the value in the input field according to the formula associated with the segment selection.
    // Outputs the result to the result field
    @IBAction func convertValueBtn(_ sender: Any) {
        guard let textValue = self.valueToConvertField.text else {
            // valueToConvertField was nil
            self.resultField.text = "N/A"
            return
        }
        
        guard let value = Double(textValue) else {
            // textValue could not be converted to Double
            self.resultField.text = "N/A"
            return
        }
        
        if self.desiredConversionChoice.selectedSegmentIndex == 0 {
            // Conversion 1
            self.resultField.text = "Conversion 1 with \(value)"
        } else {
            // Conversion 2
            self.resultField.text = "Conversion 2 with \(value)"
        }
    }
    

}

