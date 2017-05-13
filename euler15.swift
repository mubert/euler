//: Playground - noun: a place where people can play

import UIKit

// Using Ints would overflow for the massive values involved.
func factorial(_ num: Int) -> Double {
    return (1...num).reduce(1.0) { $0 * Double($1) }
}

// The answer is 40! / 20! * 20! = 137846528820
factorial(40) / (factorial(20) * factorial(20))
