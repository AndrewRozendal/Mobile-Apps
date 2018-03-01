//
//  Movie.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

class Movie {
    // Properties
    let title: String
    let genres: [Genres]
    let actors: [String]
    var rating: uint
    var isFavourite: Bool
    var comments: String
    let image: UIImage
    
    // Initializes a movie object
    init(title: String, genres: [Genres], actors: [String], rating: uint, isFavourite: Bool, comments: String, image: UIImage = #imageLiteral(resourceName: "defaultImage")){
        self.title = title
        self.genres = genres
        self.actors = actors
        self.rating = rating
        self.isFavourite = isFavourite
        self.comments = comments
        self.image = image;
    }
}
