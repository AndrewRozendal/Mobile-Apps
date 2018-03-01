//
//  SearchViewController.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-28.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class SearchViewController: UIViewController {
    var movieCollection: MovieCollection? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "searchSelected" {
            
            guard let collection = movieCollection else {
                fatalError("Movie collection was not initialized")
            }
            
            guard let destination = segue.destination as? MovieItemTableViewController else {
                // Destination was unable to be cast as MovieItemTableViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            //TODO: Grab all movies that conform to search params and store in an array
            //TODO: Update movieCollection.searchResults with the search results
            
            // Pass data to new view
            destination.movieCollection = collection
            
            //TODO: Update this to reflect Search State
            destination.currentState = States.EntireCollection
        }
    }

}
