//
//  Movie.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation

class Movie {
    // Properties
    let title: String
    let genres: [String]
    let actors: [String]
    let rating: uint
    let isFavourite: Bool
    let comments: String
    
    // Initializes a movie object
    init(title: String, genres: [String], actors: [String], rating: uint, isFavourite: Bool, comments: String){
        self.title = title
        self.genres = genres
        self.actors = actors
        self.rating = rating
        self.isFavourite = isFavourite
        self.comments = comments
    }
}
