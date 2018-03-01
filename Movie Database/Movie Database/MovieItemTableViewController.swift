//
//  MovieItemTableViewController.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

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

    // MARK: - Table view data source

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
        } else {
            fatalError("CurrentState is an illegal state")
        }
        
        return count
    }
    
    // Recycle table view cells for efficiency reasons
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieItemTableViewCell else {
            fatalError("Selected cell in not of type \(cellIdentifier)")
        }
        
        guard let collection = movieCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        
        if currentState == nil {
            // CurrentState was not set properly
            fatalError("State not set for table - no context of what to show")
        }
        
        var movie: Movie
        if(currentState == States.EntireCollection){
            movie = collection.entireCollection[indexPath.row]
        } else if (currentState == States.Favourites) {
            movie = collection.entireCollection[collection.favourites[indexPath.row]]
        } else {
            fatalError("CurrentState is an illegal state")
        }

        cell.movieImage.image = movie.image
        cell.movieTitle.text = movie.title
        cell.movieRating.text = String(movie.rating)
        return cell
    }

    // MARK: - Navigation
    
    // Prepares the MovieDetails page the app is about to navigate to with the relevant movie
    // object which contains the required logic
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let selectedCell = sender as? MovieItemTableViewCell else {
            // The sender is not a MovieItemTableViewCell
            fatalError("Unexpected sender \(String(describing: sender))")
        }
        
        guard let cellLabelText = selectedCell.movieTitle.text else {
            // The text on the label of the selected cell is nil
            fatalError("Selected cell has no label with text")
        }
        
        guard let collection = movieCollection else {
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
            for i in 0 ..< collection.entireCollection.count {
                if collection.entireCollection[i].title == cellLabelText{
                    movieIndex = i
                    break
                }
            }
        } else if (currentState == States.Favourites) {
            // Search for matching Movie in favourites and grab the index of the movie in the entireCollection
            for i in 0 ..< collection.favourites.count{
                if collection.entireCollection[collection.favourites[i]].title == cellLabelText{
                    movieIndex = collection.favourites[i]
                }
            }
        } else {
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
        
        destination.currentMovieIndex = i
        destination.movieCollection = movieCollection
        destination.currentState = currentState
    }
    
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
}
