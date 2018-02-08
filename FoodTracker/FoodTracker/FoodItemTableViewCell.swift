//
//  FoodItemTableViewCell.swift
//  FoodTracker
//
//  Created by MacBook on 2018-02-05.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    //MARK: Attributes
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var expiryIndicator: ExpiryIndicator!
    
    //MARK: Delegate Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Actions
    
}
