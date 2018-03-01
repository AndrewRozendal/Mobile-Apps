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
        guard let collection = movieCollection?.entireCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        return collection.count
    }
    
    // Recycle table view cells for efficiency reasons
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieItemTableViewCell else {
            fatalError("Selected cell in not of type \(cellIdentifier)")
        }
        
        guard let collection = movieCollection?.entireCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        
        let movie = collection[indexPath.row]
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
        
        guard let collection = movieCollection?.entireCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        
        var movieIndex: Int?
        
        for i in 0 ..< collection.count {
            if collection[i].title == cellLabelText{
                movieIndex = i
                break
            }
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
    }

}
