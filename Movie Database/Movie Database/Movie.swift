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
    let id: Int
    let title: String
    let genres: [Genres]
    let actors: [String]
    var rating: Int
    var isFavourite: Bool
    var comments: String
    let image: UIImage
    
    // Initializes a movie object
    init(id: Int, title: String, genres: [Genres], actors: [String], rating: Int, isFavourite: Bool, comments: String, image: UIImage = #imageLiteral(resourceName: "defaultImage")){
        self.id = id
        self.title = title
        self.genres = genres
        self.actors = actors
        self.rating = rating
        self.isFavourite = isFavourite
        self.comments = comments
        self.image = image;
    }
}
