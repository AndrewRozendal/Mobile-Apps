//
//  SearchViewController.swift
//  Movie Database
//
//  Created by Andrew Rozendal 08 March 2018
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class SearchViewController: UIViewController {
    // MARK: Properties
    
    // The user input search field
    @IBOutlet weak var searchField: UITextField!
    
    // Reference to the movie db object
    var movieCollection: MovieCollection? = nil
    
    // Segments for user to select search areas
    @IBOutlet weak var searchArea: UISegmentedControl!
    
    // Switches for genre searchs
    @IBOutlet weak var allGenres: UISwitch!
    @IBOutlet weak var actionGenre: UISwitch!
    @IBOutlet weak var comedyGenre: UISwitch!
    @IBOutlet weak var romanceGenre: UISwitch!
    @IBOutlet weak var scifiGenre: UISwitch!
    @IBOutlet weak var documentaryGenre: UISwitch!
    
    // Stores a reference to all switches so we can iterate over them
    var switches = [UISwitch]()
    
    //MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add all switches so we can iterate over them later
        switches.append(allGenres)
        switches.append(actionGenre)
        switches.append(comedyGenre)
        switches.append(romanceGenre)
        switches.append(scifiGenre)
        switches.append(documentaryGenre)
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
            
            // Disable allGenres switch to prevent user from deselecting and leaving us with no switch selected
            allGenres.isEnabled = false
         }
    }
    
    // All Genre specific Switches call this (except the allGenres switch does not, it has its own function.
    // If the sending switch is on, turn all genres off and re-enable it.  This helps ensure at least on switch
    // is set at any given time.
    @IBAction func genreToggled(_ sender: Any) {
        guard  let selectedSwitch = sender as? UISwitch else {
            // sender was not an expected UISwitch
            os_log("Sender was not a UISwitch", log: OSLog.default, type: .debug)
            return
        }
        
        if selectedSwitch.isOn {
            // We are doing a genre specific search, toggle all genres off
            allGenres.setOn(false, animated: true)
            allGenres.isEnabled = true
        } else {
            // Make sure we are not the last switch that was on.  If we were, turn on all genres
            // - a switch must be on at all times
            var aSwitchIsSet = false
            for s in switches {
                if s.isOn {
                    aSwitchIsSet = true
                    break
                }
            }
            
            //turn on all genres if nothing else is set
            if !aSwitchIsSet{
                allGenres.setOn(true, animated: true)
                // Disable allGenres to prevent user from turning off directly and leaving the app with no switch set
                allGenres.isEnabled = false
            }
        }
    }
    
    // Before we navigate, search the movieCollection and store the results in the movieCollection object
    // Then set this property in the destination to enable a reference to it.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "searchSelected" {
            guard let collection = movieCollection?.entireCollection else {
                // collection is not there
                fatalError("Movie collection was not initialized")
            }
            
            guard let destination = segue.destination.childViewControllers[0] as? MovieItemTableViewController else {
                // Destination was unable to be cast as MovieItemTableViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            var searchVal = searchField.text
            var isGenreOnlySearch = false
            
            // No user value was set, user is searching solely by genre
            if searchVal == "" {
                isGenreOnlySearch = true
            }
            
            // Searches are not case sensitive
            searchVal = searchVal!.uppercased()
            
            // Whitelist genres we are allowed to search
            var validGenres = [Genres]()
            
            // Check if allGenre switch is set
            if !allGenres.isOn {
                // All genres is not set
                // Check switches to see which are set
                // Add selected to the validGenres
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
            
            if validGenres.isEmpty || allGenres.isOn {
                // We want to search in any genre category
                // Note: We default to any genre search if nothing was set
                // - searching for a movie with no genre makes no sense
                
                // Append all genres to validGenres
                validGenres.append(Genres.Action)
                validGenres.append(Genres.Comedy)
                validGenres.append(Genres.Documentary)
                validGenres.append(Genres.Romance)
                validGenres.append(Genres.SciFi)
            }
            
            // Grab all movies that conform to search parameters and store in searchResult attribute of movieCollection
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
                
                // If movie is in valid category, check search params
                if isValid{
                    // Check if searching solely by genre - no search val
                    // Append item, skipping search by value
                    if isGenreOnlySearch {
                        movieCollection!.searchResults!.append(key)
                    } else {
                        // Search with passed text value
                        var currentMovieAdded = false
                        // title or both areas selected
                        if searchArea.selectedSegmentIndex == 0 || searchArea.selectedSegmentIndex == 2 {
                            if movie.title.uppercased().contains(searchVal!){
                                // Matching movie found
                                movieCollection!.searchResults!.append(key)
                                currentMovieAdded = true
                            }
                        }
                        
                        // actor or both areas selected
                        // In case of both search, we dont need to check actor if we already added the
                        // movie from title search
                        if !currentMovieAdded && (searchArea.selectedSegmentIndex == 1 || searchArea.selectedSegmentIndex == 2) {
                            for actor in movie.actors {
                                if actor.uppercased().contains(searchVal!){
                                    // Matching movie found
                                    movieCollection!.searchResults!.append(key)
                                }
                            }
                        }
                    }
                }
            }
            
            // Pass all the data to the new view
            destination.movieCollection = movieCollection
            destination.currentState = States.Search
        }
    }

}
