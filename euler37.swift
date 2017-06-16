/*
 https://projecteuler.net/problem=37
 Truncatable primes
 
 The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
 
 Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
 
 NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
*/

import UIKit

func findPrimes(_ num: Int) -> [Int] {
    
    let sqrtNum = Int(sqrt(Float(num)))
    var primes: [Int] = [2]
    var i = 1
    while primes.count < num {
        i += 2
        
        var found = false
        for p in primes {
            if p > sqrtNum {
                break
            }
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

let primes = Set(findPrimes(1000000))

func isTruncatablePrime(_ num: Int) -> Bool {
    
    var n = num
    var numChars = Array(String(num).characters)
    var reverse = Int(String(numChars)) ?? 0
    
    while n > 0 || reverse > 0 {
        if !primes.contains(n) || !primes.contains(reverse) {
            return false
        }
        n /= 10
        numChars.remove(at: 0)
        reverse = Int(String(numChars)) ?? 0
    }
    return true
}

var sum = 0
for i in 10 ..< 1000000 {
    if isTruncatablePrime(i) {
        print("Found truncatable prime: \(i)")
        sum += i
    }
}
print(sum)
