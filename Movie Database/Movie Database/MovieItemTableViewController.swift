//
//  MovieItemTableViewController.swift
//  Movie Database
//
//  Created by Andrew Rozendal 08 March 2018
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

// UITableViewController used to view the current relevant movies.  This can be all the movies in the collection,
// all the user's favourite movies or the movies that make up the search result of a user.
class MovieItemTableViewController: UITableViewController {
    
    // MARK: Properties
    var currentState: States? = nil
    var movieCollection: MovieCollection? = nil
    let cellIdentifier = "MovieItemTableViewCell"
    
    // MARK: Delegate functions
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

    // Get the current count of Movie objects in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        guard let collection = movieCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        
        if currentState == nil {
            // CurrentState was not set properly
            fatalError("State not set for table - no context of what to show")
        }
        
        var count: Int
        if(currentState == States.EntireCollection){
            count = collection.entireCollection.count
        } else if (currentState == States.Favourites) {
            count = collection.favourites.count
        } else if (currentState == States.Search){
            guard let searchResults = collection.searchResults else {
                fatalError("In search state but searchResults not set")
            }
            count = searchResults.count
        } else {
            fatalError("CurrentState is an illegal state")
        }
        
        return count
    }
    
    // Recycle table view cells for efficiency reasons
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieItemTableViewCell else {
            // cell is wrong type
            fatalError("Selected cell in not of type \(cellIdentifier)")
        }
        
        guard let collection = movieCollection else {
            // MovieCollection was not set properly
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        
        if currentState == nil {
            // CurrentState was not set properly
            fatalError("State not set for table - no context of what to show")
        }
        
        // Grab the current movie instance depending on current state
        var movie: Movie?
        if(currentState == States.EntireCollection){
            movie = collection.entireCollection[indexPath.row]
        } else if (currentState == States.Favourites) {
            movie = collection.entireCollection[collection.favourites[indexPath.row]]
        } else if (currentState == States.Search) {
            guard let searchResults = collection.searchResults else {
                // No search results
                fatalError("State is search but searchResults was not set")
            }
            movie = collection.entireCollection[searchResults[indexPath.row]]
        } else {
            // unexpected state
            fatalError("CurrentState is an illegal state")
        }
        
        // Make sure we were able to grab our movie instance
        guard let m = movie else {
            // we dont have a movie instance
            fatalError("Movie key was not a valid key in the Movie Dictionary")
        }
        
        // Set cell with movie details
        cell.movieImage.image = m.image
        cell.movieTitle.text = m.title
        cell.movieRating.currentMovie = m
        cell.movieRating.rating = m.rating
        cell.movieRating.desiredFunctionality = Functionality.Info
        return cell
    }

    // MARK: - Navigation
    
    // Prepares the MovieDetails page the app is about to navigate to with the relevant movie
    // object which contains the required logic
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "homeScreen"{
            guard let destination = segue.destination.childViewControllers[0] as? HomeScreenViewController else {
                // Destination was unable to be cast as HomeScreenViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            destination.movieCollection = movieCollection
        } else if segue.identifier == "movieDetails" {
            guard let selectedCell = sender as? MovieItemTableViewCell else {
                // The sender is not a MovieItemTableViewCell
                fatalError("Unexpected sender \(String(describing: sender))")
            }
        
            guard let cellLabelText = selectedCell.movieTitle.text else {
                // The text on the label of the selected cell is nil
                fatalError("Selected cell has no label with text")
            }
        
            guard let collection = movieCollection else {
                // MovieCollection was not set properly
                fatalError("Movie Collection is nil - should have been passed from previous page")
            }
        
            if currentState == nil {
                // CurrentState was not set properly
                fatalError("State not set for table - no context of what to show")
            }
        
            //Store found index
            var movieIndex: Int?
        
            if(currentState == States.EntireCollection){
                // Search for matching Movie in the entireCollection and grab index
                for (id, movie) in collection.entireCollection {
                    if movie.title == cellLabelText{
                        // this is our matching movie, get the index
                        movieIndex = id
                        break
                    }
                }
            } else if (currentState == States.Favourites) {
                // Search for matching Movie in favourites and grab the index of the movie in the entireCollection
                for i in 0 ..< collection.favourites.count{
                    guard let m = collection.entireCollection[collection.favourites[i]] else {
                        // favourite id does not match any movie id in the collection
                        fatalError("Favourites had an id that was not a key in the entireCollection")
                    }
                    if m.title == cellLabelText{
                        // this is our matching movie, get the index
                        movieIndex = collection.favourites[i]
                    }
                }
            } else if (currentState == States.Search) {
                // Search for matching Movie in searchResults and grab the index of the movie in the entireCollection
                guard let searchResults = collection.searchResults else {
                    // collection has no serachResults
                    fatalError("State is search but searchResults was not set")
                }
                
                for i in 0 ..< searchResults.count{
                    guard let m = collection.entireCollection[searchResults[i]] else {
                        // id doesnt match any collection id
                        fatalError("Search Results had an id that was not a key in the entireCollection")
                    }
                    if m.title == cellLabelText{
                        movieIndex = searchResults[i]
                    }
                }
            } else {
                // unexpected state
                fatalError("CurrentState is an illegal state")
            }
        
            guard let i = movieIndex else {
                // movie index was never initialized
                os_log("Movie Index was not set properly", log: OSLog.default, type: .debug)
                return
            }

            guard let destination = segue.destination as? MovieDetailsViewController else {
                // Destination was unable to be cast as MovieDetailsViewController
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            // Set destination with required data
            destination.currentMovieIndex = i  // the current movie id
            destination.movieCollection = movieCollection  // the current movieCollection
            destination.currentState = currentState  // the state the app is in
        }
    }
    
    // Set the title for the Table depending on the state of the app
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var text = ""
        
        guard let state = currentState else {
            // CurrentState was not set properly
            fatalError("State not set for table - no context of what to show")
        }
        
        switch(state){
            
        case States.EntireCollection:
            text = "All Movies"
        case States.Favourites:
            text = "Favourite Movies"
        case States.Search:
            text = "Search Results"
        // This should never be executed - here in case we add a State to States and forget to handle.
        default: fatalError("currentState was not valid")
            
        }
        
        return text
    }
    
    
    // Refresh the table when returning from another page - items may have changed if viewing favourites
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
