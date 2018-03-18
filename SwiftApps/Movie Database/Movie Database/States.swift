//
//  States.swift
//  Movie Database
//
//  Created by Andrew Rozendal 08 March 2018
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation

// Used to track the current state of the Movie Database App
enum States {
    case EntireCollection // We are browsing
    case Favourites // We are looking at Favourites
    case Search // We are looking at search results
}
