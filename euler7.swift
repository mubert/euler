/*
 https://projecteuler.net/problem=7
 
 By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
 
 What is the 10,001st prime number?
*/

import UIKit

func findPrimes(_ num: Int) -> Int {
    
    var primes: [Int] = [2]
    var i = 2
    while primes.count < num {
        i += 1
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
    return primes.last!
}

let solution = findPrimes(10001)
print(solution)
