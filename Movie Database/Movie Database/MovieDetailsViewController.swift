//
//  MovieDetailsViewController.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class MovieDetailsViewController: UIViewController {
    // MARK: Properties
    // Context sensitive button to interact with user favourites
    @IBOutlet weak var favouriteActionButton: UIButton!
    // Movie image
    @IBOutlet weak var movieImage: UIImageView!
    // Movie title
    @IBOutlet weak var movieTitle: UILabel!
    // Genres label
    @IBOutlet weak var movieGenres: UILabel!
    // Actors label
    @IBOutlet weak var movieActors: UILabel!
    // Comments Label
    @IBOutlet weak var movieComments: UILabel!
    // Provides feedback to user on updates ie Rate clicked
    @IBOutlet weak var updateNotification: UILabel!
    // Provides the rating of the current movie.  Also provides buttons to update it
    @IBOutlet weak var movieRating: RatingControl!
    
    // Current Movie instance
    var currentMovieIndex: Int? = nil
    var movieCollection: MovieCollection? = nil
    var currentState: States? = nil
    
    // MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set labels for the view based on the movie instance
        guard let i = currentMovieIndex else {
            os_log("Could not grab attributes for movie from movieIndex that was nil", log: OSLog.default, type: .debug)
            return
        }
        
        guard let collection = movieCollection?.entireCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        /*
        if currentState == nil {
            // CurrentState was not set properly
            fatalError("State not set for table - no context of what to show")
        }
        */
        guard let m = collection[i] else {
            fatalError("Movie index was not a valid key in movieCollection")
        }
        
        self.movieTitle.text = m.title
        self.movieImage.image = m.image
        
        // Handle that comments can be long - ie multiline - by resizing label after adding text
        self.movieComments.text = m.comments
        self.movieComments.sizeToFit()
        
        // Let RatingControl know about the current instance
        self.movieRating.rating = m.rating
        self.movieRating.currentMovie = m
        self.movieRating.desiredFunctionality = Functionality.Clickable
        
        var genres = ""
        for i in 0 ..< m.genres.count {
            genres.append(m.genres[i].rawValue)
            if(i < m.genres.count - 1){
                genres.append(", ")
            }
        }
        self.movieGenres.text = genres
        
        var actors = ""
        for i in 0 ..< m.actors.count {
            actors.append(m.actors[i])
            if(i < m.actors.count - 1){
                actors.append(", ")
            }
        }
        self.movieActors.text = actors
        
        
        
        // Set favourite button text appropriately
        if(m.isFavourite){
            self.favouriteActionButton.setTitle("Remove from Favourites", for: UIControlState.normal)
        } else {
            self.favouriteActionButton.setTitle("Add to Favourites", for: UIControlState.normal)
        }
        
        self.updateNotification.text = ""
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func updateFavourites(_ sender: Any) {
        guard let index = currentMovieIndex else {
            fatalError("No current Movie index set")
        }
        
        guard let m = movieCollection?.entireCollection[index] else {
            fatalError("Unable to access current movie from collection")
        }
        
        if m.isFavourite {
            m.isFavourite = false
            self.favouriteActionButton.setTitle("Add to Favourites", for: UIControlState.normal)
            
            // Find favourite where value is this index and remove
            var favIndex: Int? = nil;
            for i in 0 ..< movieCollection!.favourites.count{
                if movieCollection!.favourites[i] == index{
                    favIndex = i
                }
            }
            
            if favIndex != nil{
                movieCollection?.favourites.remove(at: favIndex!)
                self.updateNotification.text = "Removed from Favourites!"
            } else {
                fatalError("Could not find favourite movie index to remove")
            }
        } else {
            m.isFavourite = true
            self.favouriteActionButton.setTitle("Remove from Favourites", for: UIControlState.normal)

            // Append to favourites
            movieCollection?.favourites.append(index)
            self.updateNotification.text = "Added to Favourites!"
        }
        
        // Regardless of action, save to make changes persistant!
        save()
    }
    
    private func save(){
        // Enable saving
        guard let collection = movieCollection else {
            fatalError("Tried to save a movieCollection that didnt exist")
        }
        if !NSKeyedArchiver.archiveRootObject(collection, toFile: MovieCollection.archiveURL.path){
            os_log("Cannot save in %@", log: OSLog.default, type: .debug, MovieCollection.archiveURL.path)
        }
    }
}
