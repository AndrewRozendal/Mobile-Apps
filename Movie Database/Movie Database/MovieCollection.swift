//
//  MovieCollection.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-28.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation

class MovieCollection {
    let userName: String
    let entireCollection: [Movie]  // select * from movies where userId = x
    let favourites: [Movie]  //select * from favourites where userID = x
    
    init(userName: String, entireCollection: [Movie], favourites: [Movie]){
        self.userName = userName
        self.entireCollection = entireCollection
        self.favourites = favourites
    }
    
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
    static func generateFavourites() -> [Movie]{
        let favourites: [Movie] = [
            Movie(title: "testTitle", genres: ["Action, Comedy"], actors: ["Jenniffer", "Bob"], rating: 5, isFavourite: true, comments: "This is a great movie!!!")
        ]
        return favourites
    }
}
