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
    // Context sensitive button to allow user to see previous rating and or send new rating
    @IBOutlet weak var rateButton: UIButton!
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
    // Current Rating label
    @IBOutlet weak var movieRating: UILabel!
    // Comments Label
    @IBOutlet weak var movieComments: UILabel!
    
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
        
        guard let collection = movieCollection else {
            fatalError("Movie Collection is nil - should have been passed from previous page")
        }
        
        if currentState == nil {
            // CurrentState was not set properly
            fatalError("State not set for table - no context of what to show")
        }
        
        var movies: [Movie]
        if(currentState == States.EntireCollection){
            movies = collection.entireCollection
        } else if (currentState == States.Favourites) {
            movies = collection.favourites
        } else {
            fatalError("CurrentState is an illegal state")
        }

        let m = movies[i]
        
        self.movieTitle.text = m.title
        self.movieImage.image = m.image
        self.movieRating.text = String(m.rating)
        self.movieComments.text = m.comments
        
        var genres = ""
        for i in 0 ..< m.genres.count {
            genres.append(m.genres[i])
            if(!(i < m.genres.count - 2)){
                genres.append(", ")
            }
        }
        self.movieGenres.text = genres
        
        var actors = ""
        for i in 0 ..< m.actors.count {
            actors.append(m.actors[i])
            if(!(i < m.actors.count - 2)){
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
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
