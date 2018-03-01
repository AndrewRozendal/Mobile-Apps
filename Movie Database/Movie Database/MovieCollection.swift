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
    let userName: String  // the user's name
    let entireCollection: [Movie]  // a list of all Movie objects
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
            Movie(title: "testTitle", genres: [Genres.Action, Genres.Comedy], actors: ["Jenniffer", "Bob"], rating: 5, isFavourite: true, comments: "This is a great movie!!!"),
            Movie(title: "Titanic", genres: [Genres.Romance], actors: ["Leo"], rating: 3, isFavourite: false, comments: "Very sad :(", image: #imageLiteral(resourceName: "titanic")),
            Movie(title: "Saving Private Ryan", genres: [Genres.Action], actors: ["Tom Hanks"], rating: 5, isFavourite: true, comments: "A classic", image: #imageLiteral(resourceName: "savingPrivateRyan")),
            Movie(title: "Star Wars Episode I", genres: [Genres.SciFi], actors: ["Mark"], rating: 4, isFavourite: false, comments: "First prequel movie", image: #imageLiteral(resourceName: "starwarsI")),
            Movie(title: "Star Wars Episode II", genres: [Genres.SciFi], actors: ["Mark"], rating: 4, isFavourite: false, comments: "Second prequel movie", image: #imageLiteral(resourceName: "starwarsII"))
        ]
        return collection
    }
    
    // For testing
    static func generateFavourites() -> [Int]{
        let favourites: [Int] = [0]
        return favourites
    }
}
