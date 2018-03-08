//
//  HomeScreenViewController.swift
//  Movie Database
//
//  Created by Andrew Rozendal 08 March 2018
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class HomeScreenViewController: UIViewController {
    //MARK: Properties
    var movieCollection: MovieCollection? = nil
    
    // MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if movieCollection == nil {
            //loading
            if let restored = loadItems(){
                // Succesfully loaded saved collection
                movieCollection = restored
            } else {
                // First time user, generate with static methods
                movieCollection = MovieCollection(entireCollection: MovieCollection.generateCollection(), favourites: MovieCollection.generateFavourites())
            }
        } else {
            // We already have a movieCollection, no action required
        }
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
            
            guard let destination = segue.destination.childViewControllers[0] as? MovieItemTableViewController else {
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
            
            guard let destination = segue.destination.childViewControllers[0] as? MovieItemTableViewController else {
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
    
    // Enable loading
    func loadItems() -> MovieCollection? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MovieCollection.archiveURL.path) as? MovieCollection
    }
    
}

