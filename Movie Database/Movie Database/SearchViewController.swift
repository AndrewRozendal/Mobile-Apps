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
    
    @IBOutlet weak var searchArea: UISegmentedControl!
    
    @IBOutlet weak var allGenres: UISwitch!
    
    @IBOutlet weak var actionGenre: UISwitch!
    
    @IBOutlet weak var comedyGenre: UISwitch!
    
    @IBOutlet weak var romanceGenre: UISwitch!
    
    @IBOutlet weak var scifiGenre: UISwitch!
    
    @IBOutlet weak var documentaryGenre: UISwitch!
    
    
    //MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    // Called when all genre switch is toggled.  Turns all other switches to deselected if all genre switch is selected
    @IBAction func allGenresToggled(_ sender: Any) {
         if allGenres.isOn {
            // Searching all genres
            // Set all other genre options to deselected
            actionGenre.setOn(false, animated: true)
            comedyGenre.setOn(false, animated: true)
            documentaryGenre.setOn(false, animated: true)
            romanceGenre.setOn(false, animated: true)
            scifiGenre.setOn(false, animated: true)
         }
    }
    
    // All Genre specific Switches call this (except the allGenres switch does not, it has its own fn()  If the sending switch is on, turn all genres off
    @IBAction func genreToggled(_ sender: Any) {
        guard  let selectedSwitch = sender as? UISwitch else {
            os_log("Sender was not a UISwitch", log: OSLog.default, type: .debug)
            return
        }
        
        if selectedSwitch.isOn {
            // We are doing a genre specific search, toggle all genres off
            allGenres.setOn(false, animated: true)
        }
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
            
            // Whitelist genres we are allowed to search
            var validGenres = [Genres]()
            
            // Check if allGenre switch is set
            if allGenres.isOn {
                validGenres.append(Genres.Action)
                validGenres.append(Genres.Comedy)
                validGenres.append(Genres.Documentary)
                validGenres.append(Genres.Romance)
                validGenres.append(Genres.SciFi)
            } else {
                // Check switches
                if actionGenre.isOn && actionGenre.isEnabled {
                    validGenres.append(Genres.Action)
                }
                
                if comedyGenre.isOn && actionGenre.isEnabled {
                    validGenres.append(Genres.Comedy)
                }
                
                if documentaryGenre.isOn && documentaryGenre.isEnabled {
                    validGenres.append(Genres.Documentary)
                }
                
                if romanceGenre.isOn && romanceGenre.isEnabled {
                    validGenres.append(Genres.Romance)
                }
                
                if scifiGenre.isOn && scifiGenre.isEnabled {
                    validGenres.append(Genres.SciFi)
                }
            }
            
            // Grab all movies that conform to search params and store in searchResult attribute of movieCollection
            // clear all old results
            movieCollection!.searchResults = [Int]()
            for (key, movie) in collection {
                // Check current movie to see if valid genre
                var isValid = false
                for genre in validGenres {
                    if movie.genres.contains(genre){
                        isValid = true
                        break
                    }
                }
                
                if isValid{
                    var currentMovieAdded = false
                    // title or both areas selected
                    if searchArea.selectedSegmentIndex == 0 || searchArea.selectedSegmentIndex == 2 {
                        if movie.title.uppercased().contains(searchVal!){
                            movieCollection!.searchResults!.append(key)
                            currentMovieAdded = true
                        }
                    }
                    
                    
                    
                    // Dont need to check if we added movie from title search
                    // actor or both areas selected
                    if !currentMovieAdded && (searchArea.selectedSegmentIndex == 1 || searchArea.selectedSegmentIndex == 2) {
                        for actor in movie.actors {
                            if actor.uppercased().contains(searchVal!){
                                movieCollection!.searchResults!.append(key)
                                //currentMovieAdded = true  //not necessary right now, but might be in future if another search area is added
                            }
                        }
                    }
                }
            }
            
            // Pass data to new view
            destination.movieCollection = movieCollection
            destination.currentState = States.Search
        }
    }

}
