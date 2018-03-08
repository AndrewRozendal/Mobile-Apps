//
//  MovieCollection.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-28.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation
import os

// Represents the entire MovieCollection and associated data.  This includes a dictionary with the entire movie collection,
// an array that holds the ids of all favourites, and search results when required.
class MovieCollection: NSObject, NSCoding{
    // For saving
    class PropertyKey{
        static let entireCollection = "entireCollection"
        static let favourites = "favourites"
    }
    
    // Properties
    let entireCollection: [Int: Movie]  // a dictionary of all Movie objects.  Key is the Movie ID, value is the Movie
    var favourites: [Int]  // the index locations of favourite Movies contained in entireCollection
    var searchResults: [Int]?  // the index locations of Movies that met a search criterea
    
    // Initialize a MovieCollection the entireCollection and favourites
    // The entire collection should be a Dictionary of Int:Movie where the Int is the id of the movie.
    // The favourites should be an array of Int where the Int is the id of the favourite movie.
    // Both of these must be consistent with one another or the app will crash!
    // You can use the static helper methods to generate each of these - note: these static methods should only be used
    // in combination with the other since they must be consistent with one another!
    init(entireCollection: [Int: Movie], favourites: [Int]){
        self.entireCollection = entireCollection
        self.favourites = favourites
        self.searchResults = nil
    }
    
    // Static method that populates a Dictionary with pre-defined Movies.  This should be used in conjunction with the static generateFavourites() method since it generates Movies that are favourites that need to be added to the favourites array.
    static func generateCollection() -> [Int: Movie]{
        let collection: [Int: Movie] = [
            0: Movie(id: 0, title: "testTitle", genres: [Genres.Action, Genres.Comedy], actors: ["Jenniffer", "Bob"], rating: 5, isFavourite: true, comments: "This is a great movie!!!"),
            1: Movie(id: 1, title: "Titanic", genres: [Genres.Romance], actors: ["Leo"], rating: 3, isFavourite: false, comments: "Very sad :(", image: #imageLiteral(resourceName: "titanic")),
            2: Movie(id: 2, title: "Saving Private Ryan", genres: [Genres.Action], actors: ["Tom Hanks"], rating: 5, isFavourite: true, comments: "A classic", image: #imageLiteral(resourceName: "savingPrivateRyan")),
            3: Movie(id: 3, title: "Star Wars Episode I", genres: [Genres.SciFi], actors: ["Mark"], rating: 4, isFavourite: false, comments: "First prequel movie", image: #imageLiteral(resourceName: "starwarsI")),
            4: Movie(id: 4, title: "Star Wars Episode II", genres: [Genres.SciFi], actors: ["Mark"], rating: 4, isFavourite: false, comments: "Second prequel movie", image: #imageLiteral(resourceName: "starwarsII")),
            5: Movie(id: 5, title: "Avatar", genres: [Genres.Action, Genres.SciFi], actors: ["Jane", "Jon", "Mary"], rating: 3, isFavourite: false, comments: "This is a really long test comment.  This is to test that multi-line comments work.", image: #imageLiteral(resourceName: "avatar")),
            6: Movie(id: 6, title: "testTitle2", genres: [Genres.Comedy], actors: ["Geoff", "Bob"], rating: 4, isFavourite: true, comments: "This is a good movie"),
            7: Movie(id: 7, title: "testTitle3", genres: [Genres.Documentary], actors: ["Jack", "Bob"], rating: 2, isFavourite: true, comments: "This is a an ok movie")
        ]
        return collection
    }
    
    // Static method that populates an array with the ids of Favourites.  This should be used in conjunction with the static generateCollection() method since it generates Favourites that match that collection.
    static func generateFavourites() -> [Int]{
        let favourites: [Int] = [0, 2, 6, 7]
        return favourites
    }
    
    // Enable data persistency
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("movieCollection")
    
    // Enable loading
    required convenience init?(coder aDecoder: NSCoder){
        guard let collection = aDecoder.decodeObject(forKey: PropertyKey.entireCollection) as? [Int: Movie] else {
            // collection could not be loaded
            os_log("Missing movie collection", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let favourites = aDecoder.decodeObject(forKey: PropertyKey.favourites) as? [Int] else {
            // favourites could not be loaded
            os_log("Missing favourites list", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(entireCollection: collection, favourites: favourites)
    }
    
    // Enable saving
    func encode(with aCoder: NSCoder){
        aCoder.encode(entireCollection, forKey: PropertyKey.entireCollection)
        aCoder.encode(favourites, forKey: PropertyKey.favourites)
    }
}
