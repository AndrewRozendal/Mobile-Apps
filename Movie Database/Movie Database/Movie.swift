//
//  Movie.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class Movie: NSObject, NSCoding{
    // For saving
    class PropertyKey{
        static let id = "id"
        static let title = "title"
        static let genres = "genres"
        static let actors = "actors"
        static let rating = "rating"
        static let isFavourite = "isFavourite"
        static let comments = "comments"
        static let image = "image"
    }
    
    // Properties
    let id: Int
    let title: String
    let genres: [Genres]
    let actors: [String]
    var rating: Int
    var isFavourite: Bool
    var comments: String
    let image: UIImage
    
    // Initializes a movie object.  The id should be a unique identifier for the movie.  All parameters are required except image, which will use a default placeholder image if not provided.
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
    
    // Enable data persistency
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("movieItems")
    
    // For saving
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(title, forKey: PropertyKey.title)
        let genreStrings = genres.map({$0.rawValue})
        aCoder.encode(genreStrings, forKey: PropertyKey.genres)
        aCoder.encode(actors, forKey: PropertyKey.actors)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(isFavourite, forKey: PropertyKey.isFavourite)
        aCoder.encode(comments, forKey: PropertyKey.comments)
        aCoder.encode(image, forKey: PropertyKey.image)
    }
    
    // For loading
    required convenience init?(coder aDecoder: NSCoder) {
        guard let id = aDecoder.decodeInteger(forKey: PropertyKey.id) as? Int else {
            os_log("Missing id", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Missing title", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let genres = aDecoder.decodeObject(forKey: PropertyKey.genres) as? [Genres] else {
            os_log("Missing genres", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let actors = aDecoder.decodeObject(forKey: PropertyKey.actors) as? [String] else {
            os_log("Missing actors", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating) as? Int else {
            os_log("Missing rating", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let isFavourite = aDecoder.decodeBool(forKey: PropertyKey.isFavourite) as? Bool else {
            os_log("Missing isFavourite", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let comments = aDecoder.decodeObject(forKey: PropertyKey.comments) as? String else {
            os_log("Missing comments", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage else {
            os_log("Missing image", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(id: id, title: title, genres: genres, actors: actors, rating: rating, isFavourite: isFavourite, comments: comments, image: image)
    }
}
