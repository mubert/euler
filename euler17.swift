/*
 https://projecteuler.net/problem=17
 
 If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
 
 If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
 
 
 NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
*/


import UIKit

func intToWords(_ num: Int) -> String {

    func digit(_ num: Int) -> String {
        switch num {
        case 1: return "one"
        case 2: return "two"
        case 3: return "three"
        case 4: return "four"
        case 5: return "five"
        case 6: return "six"
        case 7: return "seven"
        case 8: return "eight"
        case 9: return "nine"
        default: return ""
        }
    }
    
    var words = ""
    
    if num >= 1000 {
        let thousands = (num / 1000) % 10
        if thousands > 0 {
            words += digit(thousands) + " thousand "
        }
    }
    
    if num >= 100 {
        let hundreds = (num / 100) % 10
        if hundreds > 0 {
            words += digit(hundreds) + " hundred"
        }
    }
    
    let tens = num % 100
    
    if tens > 0 && num >= 100 {
        words += " and "
    }
    
    switch tens {
    case 1...9: words += digit(tens)
    case 10: words += "ten"
    case 11: words += "eleven"
    case 12: words += "twelve"
    case 13: words += "thirteen"
    case 14: words += "fourteen"
    case 15: words += "fifteen"
    case 16: words += "sixteen"
    case 17: words += "seventeen"
    case 18: words += "eighteen"
    case 19: words += "nineteen"
    case 20...29: words += "twenty " + digit(tens % 10)
    case 30...39: words += "thirty " + digit(tens % 10)
    case 40...49: words += "forty " + digit(tens % 10)
    case 50...59: words += "fifty " + digit(tens % 10)
    case 60...69: words += "sixty " + digit(tens % 10)
    case 70...79: words += "seventy " + digit(tens % 10)
    case 80...89: words += "eighty " + digit(tens % 10)
    case 90...99: words += "ninety " + digit(tens % 10)
    default: return words
    }
    return words
}

let sum = (1...1000).reduce(0) {
    $0 + intToWords($1).replacingOccurrences(of: " ", with: "").characters.count
}
print(sum)

