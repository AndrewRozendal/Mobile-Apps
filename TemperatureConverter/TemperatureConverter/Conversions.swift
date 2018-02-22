//
//  Conversions.swift
//  TemperatureConverter
//
//  Created by Andrew Rozendal on 2018-02-20.
//  Copyright © 2018 Camosun. All rights reserved.
//

import Foundation

class Conversions {
    //Required Properties for all Conversions
    let title: String
    let leftButtonText: String
    let rightButtonText: String
    let leftButtonFunction: (Double) -> Double
    let rightButtonFunction: (Double) -> Double
    
    // Initializes a Conversions object with the passed parameters
    init(title: String, leftButtonText: String, rightButtonText: String, leftButtonFunction: @escaping (Double) -> Double, rightButtonFunction: @escaping (Double) -> Double){
        self.title = title
        self.leftButtonText = leftButtonText
        self.rightButtonText = rightButtonText
        self.leftButtonFunction = leftButtonFunction
        self.rightButtonFunction = rightButtonFunction
    }
}

// Temperature Conversions
class TemperatureConversion: Conversions {
    
    //Converts the passed C value to F
    func convertCtoF(val: Double) -> Double {
        return val * 9.0 / 5.0 + 32.0
    }
    
    //Converts the passed F value to C
    func convertFtoC(val: Double) -> Double {
        return (val - 32.0) * 5.0 / 9.0
    }
    
    //Initialized by Conversions super class with Temperature specific labels
    init(){
        super.init(title: "Temperature", leftButtonText: "Cº to Fº", rightButtonText: "Fº to Cº", leftButtonFunction: convertCtoF, rightButtonFunction: convertFtoC)
    }
}

// Area Conversions
class AreaConversion: Conversions {
    
    //Converts the passed Ha value to Ac
    func convertHectarestoAcres(val: Double) -> Double {
        return val * 2.471
    }
    
    //Converts the passed Ac value to Ha
    func convertAcrestoHectares(val: Double) -> Double {
        return val * 0.405
    }
    
    //Initialized by Conversions super class with Area specific labels
    init(){
        super.init(title: "Area", leftButtonText: "ha to ac", rightButtonText: "ac to ha", leftButtonFunction: convertHectarestoAcres, rightButtonFunction: convertAcrestoHectares)
    }
}

// Length Conversions
class LengthConversion: Conversions {
    
    //Converts the passed ft value to m
    func convertFeettoMetres(val: Double) -> Double {
        return val * 0.305
    }
    
    //Converts the passed m value to ft
    func convertMetrestoFeet(val: Double) -> Double {
        return val * 3.281
    }
    
    //Initialized by Conversions super class with Length specific labels
    init(){
        super.init(title: "Length", leftButtonText: "ft to m", rightButtonText: "m to ft", leftButtonFunction: convertFeettoMetres, rightButtonFunction: convertMetrestoFeet)
    }
}

// Weight Conversions
class WeightConversion: Conversions {
    
    //Converts the passed lbs value to kg
    func convertPoundstoKilos(val: Double) -> Double {
        return val * 0.454
    }
    
    //Converts the passed kg value to lbs
    func convertKilostoPounds(val: Double) -> Double {
        return val * 2.205
    }

    //Initialized by Conversions super class with Weight specific labels
    init(){
        super.init(title: "Weight", leftButtonText: "kg to lbs", rightButtonText: "lbs to kg", leftButtonFunction: convertKilostoPounds, rightButtonFunction: convertPoundstoKilos)
    }
}





