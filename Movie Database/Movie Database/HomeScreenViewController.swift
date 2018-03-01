//
//  ViewController.swift
//  Movie Database
//
//  Created by Andrew Rozendal on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class HomeScreenViewController: UIViewController {
    var movieCollection = MovieCollection(testing: true)
    
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
            guard let collection = movieCollection else {
                fatalError("Movie collection was not initialized")
            }
            if collection.entireCollection.count <= 0 {
                //unable to pick random from a movie collection that is empty.
                os_log("Unable to pick random from a movie collection that is empty", log: OSLog.default, type: .debug)
                return
            }
            
            let rand = Int(arc4random_uniform(UInt32(collection.entireCollection.count)))

            guard let destination = segue.destination as? MovieDetailsViewController else {
                // Destination was unable to be cast as ViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            // Pass data to new view
            destination.currentMovieIndex = rand
            destination.movieCollection = collection
            destination.currentState = States.EntireCollection
            
        } else if segue.identifier == "browseSelected" {
            
            guard let collection = movieCollection else {
                fatalError("Movie collection was not initialized")
            }
            
            guard let destination = segue.destination as? MovieItemTableViewController else {
                // Destination was unable to be cast as MovieItemTableViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            // Pass data to new view
            destination.movieCollection = collection
            destination.currentState = States.EntireCollection
            
        } else if segue.identifier == "favouritesSelected" {
            
            guard let collection = movieCollection else {
                fatalError("Movie collection was not initialized")
            }
            
            guard let destination = segue.destination as? MovieItemTableViewController else {
                // Destination was unable to be cast as MovieItemTableViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            // Pass data to new view
            destination.movieCollection = collection
            destination.currentState = States.Favourites
        } else if segue.identifier == "searchSelected" {
            
            guard let collection = movieCollection else {
                fatalError("Movie collection was not initialized")
            }
            
            guard let destination = segue.destination as? SearchViewController else {
                // Destination was unable to be cast as SearchViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            // Pass data to new view
            destination.movieCollection = collection
        }
    }
    
}

