//
//  MovieCollection.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-28.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation

class MovieCollection {
    // Properties
    let userName: String
    let entireCollection: [Movie]  // select * from movies where userId = x
    var favourites: [Int]  // the index locations of favourite Movies contained in entireCollection
    
    // Initialize a MovieCollection with the owner name, entireCollection and favourites
    init(userName: String, entireCollection: [Movie], favourites: [Int]){
        self.userName = userName
        self.entireCollection = entireCollection
        self.favourites = favourites
    }
    
    // For testing
    convenience init?(testing: Bool){
        if testing {
            let userName = "testing"
            let entireCollection = MovieCollection.generateCollection()
            let favourites = MovieCollection.generateFavourites()
            self.init(userName: userName, entireCollection: entireCollection, favourites: favourites)
        } else {
            fatalError("This method must not be called if not testing")
        }
    }
    
    // For testing
    static func generateCollection() -> [Movie]{
        let collection: [Movie] = [
            Movie(title: "testTitle", genres: ["Action, Comedy"], actors: ["Jenniffer", "Bob"], rating: 5, isFavourite: true, comments: "This is a great movie!!!"),
            Movie(title: "test2", genres: ["Comedy"], actors: ["Bob"], rating: 0, isFavourite: false, comments: "I didn't like this movie")
        ]
        return collection
    }
    
    // For testing
    static func generateFavourites() -> [Int]{
        let favourites: [Int] = [0]
        return favourites
    }
}
