//
//  FoodItem.swift
//  FoodTracker
//
//  Created by Andrew Rozendal on 2018-02-05.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit
import os

class FoodItem: NSObject, NSCoding{
    
    class PropertyKey{
        static let image = "image"
        static let expiryDate = "expiryDate"
    }
    
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
    
    // Enable data persistency
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("foodItems")
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage else {
            os_log("Missing image", log: OSLog.default, type: .debug)
            return nil
        }
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.expiryDate) as? Date else {
            os_log("Missing date", log: OSLog.default, type: .debug)
            return nil
        }
        self.init(image: image, expiryDate: date)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(expiryDate, forKey: PropertyKey.expiryDate)
    }
}
