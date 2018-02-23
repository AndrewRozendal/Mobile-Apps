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
            // text was nill on selected cell
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
            // The text on the label of the selected cell is nil
            fatalError("Selected cell has no label with text")
        }
        
        var conversionIndex: Int?
        
        switch(cellLabelText){
            case conversions[0].title: conversionIndex = 0
            case conversions[1].title: conversionIndex = 1
            case conversions[2].title: conversionIndex = 2
            case conversions[3].title: conversionIndex = 3
            
            // Unexpected title for the selected cell
            default: fatalError("Unexpected title \(String(describing: selectedCell.textLabel))")
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
