/*
 https://projecteuler.net/problem=10
 
 The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 
 Find the sum of all the primes below two million.
*/


import UIKit

func findPrimes(num: Int) -> [Int] {
    
    var primes: [Int] = [2]

    for i in 3..<num {
        
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

// find the sum of all prime numbers up to 2,000,000
let solution = findPrimes(num: 2000000).reduce(0,+)
print(solution)
