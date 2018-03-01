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
    // Provides feedback to user on updates ie Rate clicked
    @IBOutlet weak var updateNotification: UILabel!
    
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
        if(currentState == States.EntireCollection || currentState == States.Favourites){
            movies = collection.entireCollection
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
        
        //TODO: This should add / remove the current movie from favourites
    }
    
    @IBAction func rateMovie(_ sender: Any) {
        self.updateNotification.text = "Not yet implemented"
        
        //TODO: This should update the rating in the movieCollection object.  This should be both in the favourites and the entire collection.  It should also update the rating label on the current page
    }
}
