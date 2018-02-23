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
    let genres: [String]
    let actors: [String]
    let rating: uint
    let isFavourite: Bool
    let comments: String
    let image: UIImage
    
    // Initializes a movie object
    init(title: String, genres: [String], actors: [String], rating: uint, isFavourite: Bool, comments: String, image: UIImage = #imageLiteral(resourceName: "defaultImage")){
        self.title = title
        self.genres = genres
        self.actors = actors
        self.rating = rating
        self.isFavourite = isFavourite
        self.comments = comments
        self.image = image;
    }
    
    convenience init(){
        self.init(title: "testTitle", genres: ["Action, Comedy"], actors: ["Jenniffer", "Bob"], rating: 2, isFavourite: true, comments: "This is a great movie!!!")
    }
}
