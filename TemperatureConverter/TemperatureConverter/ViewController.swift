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
    @IBOutlet weak var conversionTitle: UILabel!
    var currentConversion = [Conversions]()
    
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
        self.conversionTitle.text = currentConversion[0].title
        self.desiredConversionChoice.setTitle(currentConversion[0].leftButtonText, forSegmentAt: 0)
        self.desiredConversionChoice.setTitle(currentConversion[0].rightButtonText, forSegmentAt: 1)
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
            self.resultField.text = String((currentConversion[0].leftButtonFunction)(value))
        } else {
            // Conversion 2
            self.resultField.text = String((currentConversion[0].rightButtonFunction)(value))
        }
    }
    

}

