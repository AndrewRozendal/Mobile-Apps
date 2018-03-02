//
//  MovieCollection.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-28.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation
import os

class MovieCollection {
    // For saving
    class PropertyKey{
        static let userName = "userName"
        static let entireCollection = "entireCollection"
        static let favourites = "favourites"
    }
    
    // Properties
    let userName: String  // the user's name
    let entireCollection: [Int: Movie]  // a dictionary of all Movie objects.  Key is the Movie ID, value is the Movie
    var favourites: [Int]  // the index locations of favourite Movies contained in entireCollection
    var searchResults: [Int]?  // the index locations of Movies that met a search criterea
    
    // Initialize a MovieCollection with the owner name, entireCollection and favourites
    init(userName: String, entireCollection: [Int: Movie], favourites: [Int]){
        self.userName = userName
        self.entireCollection = entireCollection
        self.favourites = favourites
        self.searchResults = nil
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
    
    // For testing
    static func generateFavourites() -> [Int]{
        let favourites: [Int] = [0]
        return favourites
    }
    
    // Enable data persistency
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("movieCollection")
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.userName) as? String else {
            os_log("Missing userName", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let collection = aDecoder.decodeObject(forKey: PropertyKey.entireCollection) as? [Int: Movie] else {
            os_log("Missing movie collection", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let favourites = aDecoder.decodeObject(forKey: PropertyKey.favourites) as? [Int] else {
            os_log("Missing favourites list", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(userName: name, entireCollection: collection, favourites: favourites)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(userName, forKey: PropertyKey.userName)
        aCoder.encode(entireCollection, forKey: PropertyKey.entireCollection)
        aCoder.encode(favourites, forKey: PropertyKey.favourites)
    }
}
