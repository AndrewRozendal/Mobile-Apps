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
    // MARK: Attributes
    // The user input search field
    @IBOutlet weak var searchField: UITextField!
    // Reference to the movie db object
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
            guard let collection = movieCollection?.entireCollection else {
                fatalError("Movie collection was not initialized")
            }
            
            guard let destination = segue.destination as? MovieItemTableViewController else {
                // Destination was unable to be cast as MovieItemTableViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            var searchVal = searchField.text
            if searchVal == nil {
                //TODO: Tell the user that you have to search for something
                // OR: Do we let people refine by category here?
                return
            }
            
            // Searches are not case sensitive
            searchVal = searchVal!.uppercased()
            
            // Grab all movies that conform to search params and store in searchResult attribute of movieCollection
            // clear all old results
            movieCollection!.searchResults = [Int]()
            for (key, movie) in collection {
                // TODO: Detect user choice
                let isTitleSearch = true
                let isActorSearch = true
                if isTitleSearch {
                    if movie.title.uppercased().contains(searchVal!){
                        movieCollection!.searchResults!.append(key)
                    }
                }
                
                if isActorSearch {
                    for actor in movie.actors {
                        if actor.uppercased().contains(searchVal!){
                            movieCollection!.searchResults!.append(key)
                        }
                    }
                }
            }
            
            print(movieCollection!.searchResults!.count)

            // Pass data to new view
            destination.movieCollection = movieCollection
            destination.currentState = States.Search
        }
    }

}
