//
//  UnitConversionViewController.swift
//  TemperatureConverter
//
//  Created by MacBook on 2018-02-19.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class UnitConversionViewController: UITableViewController {
    //MARK: Properties
    // Initialize all
    let cellIdentifier = "conversionType"
    let conversions = [TemperatureConversion(), AreaConversion(), LengthConversion(), WeightConversion()]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return conversions.count
    }
 

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UnitConversionViewCell else {
            fatalError("Selected cell is not of type \(cellIdentifier)")
        }
        
        guard let label = cell.textLabel else {
            fatalError("Selected cell does not have textLabel")
        }

        // Configure the cell...
        label.text = conversions[indexPath.item].title
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let selectedCell = sender as? UnitConversionViewCell else {
            fatalError("Unexpected destination \(String(describing: sender))")
        }
        
        guard let cellLabelText = selectedCell.textLabel?.text else {
            fatalError("Selected cell has no label with text")
        }
        
        var conversionIndex: Int?
        
        switch(cellLabelText){
            
        case "Temperature": conversionIndex = 0
        case "Area": conversionIndex = 1
        case "Length": conversionIndex = 2
        case "Weight": conversionIndex = 3
            
        default: fatalError("Unexpected title \(String(describing: selectedCell.textLabel))")
            
        }
        
        guard let i = conversionIndex else {
            os_log("Cannot grab attributes from a Conversions item that is nil", log: OSLog.default, type: .debug)
            return
        }
        
        let destination = segue.destination as? ViewController
        destination?.currentConversion = conversions[i]
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

    

}
