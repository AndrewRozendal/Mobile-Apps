//
//  FoodItem.swift
//  FoodTracker
//
//  Created by Andrew Rozendal on 2018-02-05.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
class FoodItem: NSObject{
    var image: UIImage
    var expiryDate: Date
    
    // Default constructor.  Initializes a FoodItem with the default image and current date
    override convenience init() {
        self.init(image: #imageLiteral(resourceName: "defaultImage"), expiryDate: Date())
    }
    
    // Initializes a FoodItem with the specified image and expiry date
    // @param UIImage image The image to use for the FoodItem
    // @param Date expiryDate The expiry date to use for the FoodItem
    init(image: UIImage, expiryDate: Date){
        self.image = image
        self.expiryDate = expiryDate
    }
}
