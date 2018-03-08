//
//  MovieItemTableViewCell.swift
//  Movie Database
//
//  Created by MacBook on 2018-02-22.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

// Cell that contains the details of a Movie
class MovieItemTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var movieImage: UIImageView!  // the movie image
    @IBOutlet weak var movieTitle: UILabel!  // the movie title
    @IBOutlet weak var movieRating: RatingControl!  // for showing the current rating
    
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
