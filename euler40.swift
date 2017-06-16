/*
 https://projecteuler.net/problem=40
 Champernowne's constant
 
 An irrational decimal fraction is created by concatenating the positive integers:
 
 0.123456789101112131415161718192021...
 
 It can be seen that the 12th digit of the fractional part is 1.
 
 If dn represents the nth digit of the fractional part, find the value of the following expression.
 
 d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000
*/

import UIKit

func indexToDigit(_ index: Int) -> Int {
    
    var ind = index-1
    var num = 0
    var i = 0
    var digits = 0
    
    var numCount = Int(pow(10.0, Float(digits))) - Int(pow(10.0, Float(digits-1)))
    while ind >= numCount*digits {
        ind -= numCount*digits
        num += numCount
        digits += 1
        numCount = Int(pow(10.0, Float(digits))) - Int(pow(10.0, Float(digits-1)))
    }
    
    num += ind / digits
    i = ind % digits
    return Int(String(Array(String(num).characters)[i]))!
}

var product = 1
product *= indexToDigit(1)
product *= indexToDigit(10)
product *= indexToDigit(100)
product *= indexToDigit(1000)
product *= indexToDigit(10000)
product *= indexToDigit(100000)
product *= indexToDigit(1000000)
print(product)
