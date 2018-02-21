//
//  ConversionPage.swift
//  TemperatureConverter
//
//  Created by MacBook on 2018-02-20.
//  Copyright © 2018 Camosun. All rights reserved.
//

class ConversionPage {
    var title: String
    var leftButtonText: String
    var rightButtonText: String
    var leftButtonFunction: (Double) -> Double
    var rightButtonFunction: (Double) -> Double
    
    init(title: String, leftButtonText: String, rightButtonText: String, leftButtonFunction: @escaping (Double) -> Double, rightButtonFunction: @escaping (Double) -> Double){
        self.title = title
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.leftButtonFunction = leftButtonFunction
        self.rightButtonFunction = rightButtonFunction
    }
}
