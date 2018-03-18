//
//  UnitConversionViewController.swift
//  TemperatureConverter
//
//  Created by Andrew Rozendal on 2018-02-19.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class UnitConversionViewController: UITableViewController {
    //MARK: Properties
    
    // Initialize all Conversion sub-classes we want to provide
    let cellIdentifier = "conversionType"
    let conversions = [TemperatureConversion(), AreaConversion(), LengthConversion(), WeightConversion()]

    
    //MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return conversions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UnitConversionViewCell else {
            // selected cell was not a UnitConversionViewCell
            fatalError("Selected cell is not of type \(cellIdentifier)")
        }
        
        guard let label = cell.textLabel else {
            // selected cell did not have a textLabel
            fatalError("Selected cell does not have textLabel")
        }

        // Configure the cell...
        label.text = conversions[indexPath.item].title
        return cell
    }
    
    // MARK: - Navigation
    
    // Prepares the Conversion page the app is about to navigate to with the relevant conversion
    // object which contains the required logic
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let selectedCell = sender as? UnitConversionViewCell else {
            // The destination is not a UnitConversionViewCell
            fatalError("Unexpected destination \(String(describing: sender))")
        }
        
        guard let cellLabelText = selectedCell.textLabel?.text else {
            // The text on the textLabel of the selected cell is nil, or the selected cell has no textLabel
            fatalError("Selected cell has no label with text")
        }
        
        var conversionIndex: Int?
        
        // Find the matching Conversion instance in the Conversions list
        for i in 0 ..< conversions.count {
            if conversions[i].title == cellLabelText{
                conversionIndex = i
                break
            }
        }
        
        guard let i = conversionIndex else {
            // conversion index was never initialized
            os_log("Conversion Index was not set properly", log: OSLog.default, type: .debug)
            return
        }
        
        guard let destination = segue.destination as? ViewController else {
            // Destination was unable to be cast as ViewController
            fatalError("Unexpected destination \(segue.destination)")
        }
        
        destination.currentConversion = conversions[i]
    }

}
