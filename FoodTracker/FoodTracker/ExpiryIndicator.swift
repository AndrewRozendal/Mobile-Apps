//
//  ExpiryIndicator.swift
//  FoodTracker
//
//  Created by Andrew Rozendal on 2018-02-05.
//  Copyright © 2018 Camosun. All rights reserved.
//

import UIKit

class ExpiryIndicator: UIStackView {
    private var indicators = [UIImageView]()
    private let indicatorCount: Int = 10
    var indicatorPercentage: Int = 100 {
        didSet{
            // Set alpha level of each indicator element to reflect the percentage
            for i in 0..<indicatorCount{
                indicators[i].alpha = i * indicatorCount < indicatorPercentage ? 1.0 : 0.1
            }
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        for _ in 0..<self.indicatorCount {
            let indicator = UIImageView(image: #imageLiteral(resourceName: "defaultImage"))
            indicator.contentMode = .scaleToFill
            self.addArrangedSubview(indicator)
            indicators.append(indicator)
        }
    }
    
    // Sets the indicator percentage by comparing the passed date to the current date
    func setIndicatorPercentage(expDate: Date){
        let numberOfSecondsInDay: Double = 86400.0
        let diff = Double(expDate.timeIntervalSince(Date()) / numberOfSecondsInDay)
        self.indicatorPercentage = Int(diff / 30.0 * 100.0)
    }

}
