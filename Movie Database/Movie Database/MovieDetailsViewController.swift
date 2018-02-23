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
    // Movie details
    @IBOutlet weak var movieDetails: UILabel!
    
    var currentMovie: Movie? = nil
    
    // MARK: Delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set labels for the view based on the movie instance
        guard let m = currentMovie else {
            os_log("Cannot grab attributes from a Movie object that is nil", log: OSLog.default, type: .debug)
            return
        }
        
        self.movieTitle.text = m.title
        self.movieImage.image = m.image
        // TODO: This will be multiple text items combined? Or multiple seperate UI items?
        self.movieDetails.text = m.comments
        
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
