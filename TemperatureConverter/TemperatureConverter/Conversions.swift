//
//  Conversions.swift
//  TemperatureConverter
//
//  Created by MacBook on 2018-02-20.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation

class Conversions {
    let title: String
    let leftButtonText: String
    let rightButtonText: String
    let leftButtonFunction: (Double) -> Double
    let rightButtonFunction: (Double) -> Double
    init(title: String, leftButtonText: String, rightButtonText: String, leftButtonFunction: @escaping (Double) -> Double, rightButtonFunction: @escaping (Double) -> Double){
        self.title = title
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.leftButtonFunction = leftButtonFunction
        self.rightButtonFunction = rightButtonFunction
    }
}

class TemperatureConversion: Conversions {
    
    func convertCtoF(val: Double) -> Double {
        return val * 9.0 / 5.0 + 32.0
    }
    
    func convertFtoC(val: Double) -> Double {
        return (val - 32.0) * 5.0 / 9.0
    }
    
    init(){
        super.init(title: "Temperature", leftButtonText: "Cº to Fº", rightButtonText: "Fº to Cº", leftButtonFunction: convertCtoF, rightButtonFunction: convertFtoC)
    }
}


