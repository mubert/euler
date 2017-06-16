/*
 https://projecteuler.net/problem=35
 
 The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
 
 There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
 
 How many circular primes are there below one million?
*/

import UIKit

func findPrimes(_ num: Int) -> [Int] {
    
    var primes: [Int] = [2]
    
    for i in 3...num {
        
        // Is it even?
        if i & 1 == 0 {
            continue
        }
        
        var found = false
        for p in primes {
            if i % p == 0 {
                found = true
                break
            }
        }
        if found {
            continue
        }
        
        primes.append(i)
    }
    return primes
}

func numDigits(_ num: Int) -> Int {
    var digits = 0
    var remainder = num
    repeat {
        remainder = remainder / 10
        digits += 1
    } while ( remainder >= 1)
    return digits
}

// Rotate carry right
func rcrDec(_ num: Int) -> Int {
    let remainder = num % 10
    var result = num / 10
    result += remainder * Int(pow(Double(10.0), Double(numDigits(num)-1)))
    return result
}

func isCircularPrime(_ num: Int) -> Bool {
    
    // Rotate the digits and test if each permutation is a prime
    let digits = numDigits(num)
    var val = num
    for _ in 0 ..< digits {
        val = rcrDec(val)
        if !primes.contains(val) {
            return false
        }
    }
    return true
}

let primes = Set(findPrimes(1000000))
let numCircPrimes = primes.reduce(0) { $0 + (isCircularPrime($1) ? 1 : 0) }
print(numCircPrimes)

