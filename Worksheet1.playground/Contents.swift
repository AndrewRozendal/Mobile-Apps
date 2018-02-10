//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// Question #1: Write a fn() that takes in an array of strings and closure, which in turn takes in a string
// and returns a boolean.  The closure processes elements until either no more elements or closure returns
// true.

let values = ["abc", "def", "ghi", "jkl", "mno", "pqr", "stu", "vwx", "yz"]

// Iterate over an array and compare each element using passed closure.  Returns when an element is evaluated
// as true by the closure or there are no (more) elements to be processed
func myFunction(list: [String], closure:(String) -> Bool){
    print("Starting myFunction()")
    for n in list {
        let result = closure(n)
        if result {
            print("Finished\n")
            return
        }
    }
}

// Question #2 Write the 2 closures to work with the above function
// Checks if the start of searchStr matches triggerValue.  Prints the comparison and returns the result as
// a boolean.
func checkFirstLetter(searchStr: String) -> Bool{
    let triggerValue: String = "m"
    let result = searchStr.starts(with: triggerValue)
    print("Cheking if \(searchStr) starts with \(triggerValue): \(result)")
    return result
}

//Test myFunction and checkFirstLetter
myFunction(list: values, closure: checkFirstLetter)



// Returns true if the passed string is shorter than 3 characters
func checkStrLength(str: String) -> Bool{
    let desiredLength = 3
    let result = str.count < desiredLength
    print("Checking if \(str) is < \(desiredLength): \(result)")
    return result
}

//Test myFunction and checkStrLength
myFunction(list: values, closure: checkStrLength)

// Question #3 Write a fn() that takes in a number called option and an array of cloures called formulas
// Each closure takes a Double and returns a Double.  The Function returns the closure at position option,
// or nil if there is no suche closure.  Ex option == 3 converts yard to metre

// Selects the requestion option from formulas and returns the closure to evaluate that option
func chooseConversion(option: Int, formulas: [(Double) -> Double]) -> ((Double) -> Double){
    return formulas[option]
}

// Question #4 Select and use a formula from the formulas list of closures
func convertCtoF(val: Double) -> Double {
    return val * 9.0 / 5.0 + 32.0
}

func convertFtoC(val: Double) -> Double {
    return (val - 32.0) * 5.0 / 9.0
}

func convertHectarestoAcres(val: Double) -> Double {
    return val * 2.471
}

func convertAcrestoHectares(val: Double) -> Double {
    return val * 0.405
}

func convertFeettoMetres(val: Double) -> Double {
    return val * 0.305
}

func convertMetrestoFeet(val: Double) -> Double {
    return val * 3.281
}

func convertPoundstoKilos(val: Double) -> Double {
    return val * 0.454
}

func convertKilostoPounds(val: Double) -> Double {
    return val * 2.205
}

enum Formulas: Int {
    case convertCtoF = 0
    case convertFtoC
    case convertHectarestoAcres
    case convertAcrestoHectares
    case convertFeettoMetres
    case convertMetrestoFeet
    case convertPoundstoKilos
    case convertKilostoPounds
}

let myFormulas = [convertCtoF, convertFtoC, convertHectarestoAcres, convertAcrestoHectares, convertFeettoMetres, convertMetrestoFeet, convertPoundstoKilos, convertKilostoPounds]

let myCValue: Double = 20
let myFValue: Double = 0
let myHectareValue: Double = 0.405
let myAcreValue: Double = 1
let myFeetValue: Double = 3
let myMetreValue: Double = 1
let myPoundValue: Double = 1
let myKiloValue: Double = 1


// Test the conversions
print(chooseConversion(option: Formulas.convertCtoF.rawValue, formulas: myFormulas)(myCValue))
print(chooseConversion(option: Formulas.convertFtoC.rawValue, formulas: myFormulas)(myFValue))
print(chooseConversion(option: Formulas.convertHectarestoAcres.rawValue, formulas: myFormulas)(myHectareValue))
print(chooseConversion(option: Formulas.convertAcrestoHectares.rawValue, formulas: myFormulas)(myAcreValue))
print(chooseConversion(option: Formulas.convertFeettoMetres.rawValue, formulas: myFormulas)(myFeetValue))
print(chooseConversion(option: Formulas.convertMetrestoFeet.rawValue, formulas: myFormulas)(myMetreValue))
print(chooseConversion(option: Formulas.convertPoundstoKilos.rawValue, formulas: myFormulas)(myPoundValue))
print(chooseConversion(option: Formulas.convertKilostoPounds.rawValue, formulas: myFormulas)(myKiloValue))

