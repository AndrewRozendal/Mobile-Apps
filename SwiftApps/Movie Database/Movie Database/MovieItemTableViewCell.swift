//
//  MovieItemTableViewCell.swift
//  Movie Database
//
//  Created by Andrew Rozendal 08 March 2018
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

// A Table Cell that displays the details of a Movie
class MovieItemTableViewCell: UITableViewCell {
    // MARK: Properties
    // the movie image
    @IBOutlet weak var movieImage: UIImageView!
    // the movie title
    @IBOutlet weak var movieTitle: UILabel!
    // for diplaying the current rating
    @IBOutlet weak var movieRating: RatingControl!
    
    // MARK: Delegate functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
